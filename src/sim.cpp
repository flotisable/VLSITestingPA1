/**********************************************************************/
/*           This is the logic simulator for atpg                     */
/*                                                                    */
/*           Author: Bing-Chen (Benson) Wu                            */
/*           last update : 01/21/2018                                 */
/**********************************************************************/

#include <queue>

#include "atpg.h"
#include "logic_tbl.h"

/*
*   sim
*
*   RETURNS
*       no value is returned
*
*   SIDE-EFFECTS
*       changes the logic values inside some wires' data structures
*
*   perform the logic simulation 
*   event-driven technique coupled with levelling mechanism is employed
*   single pattern, no fault injected
*/

void ATPG::sim(void) {
  int i, j, ncktin, nout, nckt;

  ncktin = cktin.size();
  nckt = sort_wlist.size();
  /* for every input */
  /*TODO1*/
  //Hint:For every primary input. schedule the gates connected to it
  //---------------------------------------- hole ---------------------------------------------
  for( wptr input : cktin )
  {
     for( nptr gate : input->onode )
        gate->flag |= SCHEDULED; // schedule the gate

     input->flag &= ~CHANGED; // remove the changed flag of the input
  }
  //-------------------------------------------------------------------------------------------
  /*TODO1*/

  /*TODO2*/
  //Hint:
  /* evaluate every scheduled gate & propagate any changes
   * walk through all wires in increasing order
   * Because the wires are sorted according to their levels,
   * it is correct to evaluate the wires in increasing order. */
  //---------------------------------------- hole ---------------------------------------------
  for( i = ncktin ; i < nckt ; ++i )
  {
     wptr wire = sort_wlist[i];
     nptr gate = wire->inode.front();

     if( gate->flag & SCHEDULED ) // check if the gate is scheduled
     {
       evaluate( gate );
       gate->flag &= ~SCHEDULED; // remove the schedule of the gate
     }

     if( wire->flag & CHANGED ) // check if the wire is changed
     {
       // schedule the gates
       for( nptr gate : wire->onode )
          gate->flag |= SCHEDULED;
       // end schedule the gates

       wire->flag &= ~CHANGED; // remove the changed flag of the wire
     }
  }
  //-------------------------------------------------------------------------------------------
  /*TODO2*/

}/* end of sim */

void ATPG::evaluate(nptr n) {
    int old_value, new_value;
    int i, nin;

    old_value = n->owire.front()->value;

    /* decompose a multiple-input gate into multiple levels of two-input gates  
     * then look up the truth table of each two-input gate
     */
    nin = n->iwire.size();
    switch(n->type) {
        case AND:
        case BUF:
        case NAND:
            new_value = 1;
            for (i = 0; i < nin; i++) {
                new_value = ANDTABLE[n->iwire[i]->value][new_value];
            }
            if (n->type == NAND) {
                new_value = INV[new_value];
            }
            break;
        case OR:
        case NOR:
            new_value = 0;
            for (i = 0; i < nin; i++) {
                new_value = ORTABLE[n->iwire[i]->value][new_value];
            }
            if (n->type == NOR) {
                new_value = INV[new_value];
            }
            break;
        case NOT:
            new_value = INV[n->iwire.front()->value];
            break;
        case XOR:
            new_value = XORTABLE[n->iwire[0]->value][n->iwire[1]->value];
            break;
        case EQV:
            new_value =INV[(XORTABLE[n->iwire[0]->value][n->iwire[1]->value])];
            break;
    }
    if (old_value != new_value) {
        n->owire.front()->flag |= CHANGED;
        n->owire.front()->value = new_value;
    }
    return;
}/* end of evaluate */

int ATPG::ctoi(const char& c) {
  if(c == '2') return(2);
  if(c == '1') return(1);
  if(c == '0') return(0);
}
