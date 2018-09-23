The scripts are written to automate the process of VLSI testing PA1.

The archive contains following files.

  - makefile:             use to ease the process of PA.
  - reportStatistic.perl: use to extract the statistic information of simulation result.
  - settings:             setting file of the makefile.

To install the scripts.

  - set the PA directory to the scriptInstallPath in the settings.
  - then execute 'make installScripts'.

  or manually copy all the files into the top directory of the PA.

Here are all useful the target in the makefile.

  - default:
  
    call the makefile in src/ to build 'atpg' program.

  - test:
  
    run 'golden_atpg' and 'atpg' on all sample circuits and compare the output.

  - tags:
  
    create ctags tag for src/ source code, require 'ctags' program.

  - report:
  
    generate table for PA problem 1, require 'perl' program.
    'reportCircuits' variable in 'settings' configure which circuit in sample_circuits/ to be reported.

  - tar:
  
    create tar archive for submitting PA.
    'archiveName' variable in 'settings' configure the name of archive file.
    this should be the <student id>_pa1.
    'archiveFiles' variable in 'settings' configure the file to be put in the archive.

  - scripts:

    create tar archive for the scripts.
    this should be run only if there is any problem in the scripts,
    and you want to share the update after fix it.
    'scriptFiles' variable in 'settings' configure the file to be shared.

  - installScripts 

    install the 'scriptFiles' into 'scriptInstallPath'
    this should be run only when you download the scripts archive
    'scriptFiles' variable in 'settings' configure the files to be installed
    'scriptInstallPath' variable in 'settings' configure the install path of 'scriptFiles'

  - clean

    remove the 'atpg' program and object files
    this should be run before the target 'tar' to make a clean archive
