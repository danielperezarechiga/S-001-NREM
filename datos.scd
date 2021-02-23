//D A T O S

//Dataset # 1
//EEG

(
a = CSVFileReader.read("/Users/danielperezarechiga/Desktop/Proyecto S /S - 001/Datasets/EEG 1.csv",true,true);
i = a.flop;

~eeg1 = i[0].asFloat;
~eeg2 = i[1].asFloat;
~eeg3 = i[2].asFloat;
~eeg4 = i[3].asFloat;
~eeg5 = i[4].asFloat;
~eeg6 = i[5].asFloat;
~eeg7 = i[6].asFloat;
~eeg8 = i[7].asFloat;
//valores para amplitud

~acelerometroY = i[8].asFloat;      //valores ascendentes desde 0.478
~acelerometroX = i[9].asFloat;      //valores ascendentes desde 0.277
~acelerometroZ = i[10].asFloat;    //valores descendentes desde 0.804

~giroscopioX = i[11].asFloat;     //valores positivos y negativos.
~giroscopioY = i[12].asFloat;
~giroscopioZ = i[13].asFloat;     //valores negativos y positivos.
)

//Dataset # 2
//EEG

(
b = CSVFileReader.read("/Users/danielperezarechiga/Desktop/Proyecto S /S - 001/Datasets/EEG 2.csv",true,true);
k = b.flop;

k[2].asFloat;      //"attention"
k[3].asFloat;      //"mediacion"
k[4].asFloat;      //raw
k[5].asFloat;      //delta
k[6].asFloat;      //theta
k[7].asFloat;      //alpha 1
k[8].asFloat;      //alpha2
k[9].asFloat;      //beta1
k[10].asFloat;    //beta2
)


//Dataset # 3
//Alpha continuas.

(
~delta=k[5].asFloat;
~theta=k[6].asFloat;
~alpha1=k[7].asFloat;
~alpha2=k[8].asFloat;
)


//Dataset # 3
//Eye Tracking - Photic
//PENDIENTE.



c = CSVFileReader.read("/Users/danielperezarechiga/Desktop/Proyecto S /S - 001/Datasets/EEG Eyetracking.csv",true)
