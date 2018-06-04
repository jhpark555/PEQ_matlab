# PEQ_matlab
peq design file


To simulate the filters, data_file should be made in advance.  The following data is the good example for the file.
AT the Table 1, the 1st column is a type of filter, there are all 6 types of filters in the code one of each is, PEQ, LPF, HPF, LSF,HSF and Gain.   And the 2nd column value is the gain and the third  one is the q value and the last one is center frequency of the filter.  All the parameters’ dimension is same as ESS codes not physical one.   For example, in the gain value the real meaning is same as (gain-127)/8 and q is as q/256 .



PEQ   175     1024      60
PEQ   157      512     200
PEQ   97       51      800
PEQ   67       512    1000
PEQ   55       256    3000
PEQ   67       256    5000
PEQ   175      512   10000 
PEQ   127      180     150
PEQ   127      180     170
PEQ   127      180     200
PEQ   127      180     300
PEQ   127      180     500
PEQ   127      180     900
PEQ   127      180    1100
PEQ   127      180    1500
     ( Table 1. Example of the data file )


The following is the example to show how to execute the simulation fie.
The 1st argument is data_file.dat explained above and 2nd argument is audio file if user want to simulate and 3rd optional argument is time related simulation parameter.  If it uses, the time domain simulation figure will be shown. But if the audio file is too large, it might cause delay the total simulation time.  While in the simulating, the filters parameters are shown again to be sure.   In here total 15 number of filters are used and their values are displayed below.  The “ Filter starts and Write audio file” is the action to calculate the filter process 
And after that there will be output.wav in the same directory. That is the output of this program.  At the same time the audio file will be played through the PC speaker. ( if possible)
