function [rnewaparc roigroups]=TAU_PVC_AssignFreeSurferROIs(raparc,rsuvr);

% This assigns ROIs from freesurfer new numerical values counting up from 1
% depending on which ROI group it is assigned to
rnewaparc=zeros(length(rsuvr),1);
% 1: L_entorhinal
roigroups{1}.name=['L_entorhinal']; roigroups{1}.ind=1;
ind=find(raparc==1006 & rsuvr>0);
rnewaparc(ind)=1.*ones(length(ind),1);
% 2: R_entorhinal
roigroups{2}.name=['R_entorhinal']; roigroups{2}.ind=2;
ind=find(raparc==2006 & rsuvr>0);
rnewaparc(ind)=2.*ones(length(ind),1);
% 3: L_hippocampus
roigroups{3}.name=['L_hippocampus']; roigroups{3}.ind=3;
ind=find(raparc==17 & rsuvr>0);
rnewaparc(ind)=3.*ones(length(ind),1);
% 4: R_hippocampus
roigroups{4}.name=['R_hippocampus']; roigroups{4}.ind=4;
ind=find(raparc==53 & rsuvr>0);
rnewaparc(ind)=4.*ones(length(ind),1);
% 5: L_parahippocampal
roigroups{5}.name=['L_parahippocampal']; roigroups{5}.ind=5;
ind=find(raparc==1016 & rsuvr>0);
rnewaparc(ind)=5.*ones(length(ind),1);
% 6: L_fusiform
roigroups{6}.name=['L_fusiform']; roigroups{6}.ind=6;
ind=find(raparc==1007 & rsuvr>0);
rnewaparc(ind)=6.*ones(length(ind),1);
% 7: L_lingual
roigroups{7}.name=['L_lingual']; roigroups{7}.ind=7;
ind=find(raparc==1013 & rsuvr>0);
rnewaparc(ind)=7.*ones(length(ind),1);
% 8: L_amygdala
roigroups{8}.name=['L_amygdala']; roigroups{8}.ind=8;
ind=find(raparc==18 & rsuvr>0);
rnewaparc(ind)=8.*ones(length(ind),1);
% 9: R_parahippocampal
roigroups{9}.name=['R_parahippocampal']; roigroups{9}.ind=9;
ind=find(raparc==2016 & rsuvr>0);
rnewaparc(ind)=9.*ones(length(ind),1);
% 10: R_fusiform
roigroups{10}.name=['R_fusiform']; roigroups{10}.ind=10;
ind=find(raparc==2007 & rsuvr>0);
rnewaparc(ind)=10.*ones(length(ind),1);
% 11: R_lingual
roigroups{11}.name=['R_lingual']; roigroups{11}.ind=11;
ind=find(raparc==2013 & rsuvr>0);
rnewaparc(ind)=11.*ones(length(ind),1);
% 12: R_amygdala
roigroups{12}.name=['R_amygdala']; roigroups{12}.ind=12;
ind=find(raparc==54 & rsuvr>0);
rnewaparc(ind)=12.*ones(length(ind),1);
% 13: L_middletemporal
roigroups{13}.name=['L_middletemporal']; roigroups{13}.ind=13;
ind=find(raparc==1015 & rsuvr>0);
rnewaparc(ind)=13.*ones(length(ind),1);
% 14: L_thalamus
roigroups{14}.name=['L_thalamus']; roigroups{14}.ind=14;
ind=find(raparc==10 & rsuvr>0);
rnewaparc(ind)=14.*ones(length(ind),1);
% 15: L_caudantcing
roigroups{15}.name=['L_caudantcing']; roigroups{15}.ind=15;
ind=find(raparc==1002 & rsuvr>0);
rnewaparc(ind)=15.*ones(length(ind),1);
% 16: L_rostantcing
roigroups{16}.name=['L_rostantcing']; roigroups{16}.ind=16;
ind=find(raparc==1026 & rsuvr>0);
rnewaparc(ind)=16.*ones(length(ind),1);
% 17: L_postcing
roigroups{17}.name=['L_postcing']; roigroups{17}.ind=17;
ind=find(raparc==1023 & rsuvr>0);
rnewaparc(ind)=17.*ones(length(ind),1);
% 18: L_isthmuscing
roigroups{18}.name=['L_isthmuscing']; roigroups{18}.ind=18;
ind=find(raparc==1010 & rsuvr>0);
rnewaparc(ind)=18.*ones(length(ind),1);
% 19: L_insula
roigroups{19}.name=['L_insula']; roigroups{19}.ind=19;
ind=find(raparc==1035 & rsuvr>0);
rnewaparc(ind)=19.*ones(length(ind),1);
% 20: L_inferiortemporal
roigroups{20}.name=['L_inferiortemporal']; roigroups{20}.ind=20;
ind=find(raparc==1009 & rsuvr>0);
rnewaparc(ind)=20.*ones(length(ind),1);
% 21: L_temppole
roigroups{21}.name=['L_temppole']; roigroups{21}.ind=21;
ind=find(raparc==1033 & rsuvr>0);
rnewaparc(ind)=21.*ones(length(ind),1);
% 22: R_middletemporal
roigroups{22}.name=['R_middletemporal']; roigroups{22}.ind=22;
ind=find(raparc==2015 & rsuvr>0);
rnewaparc(ind)=22.*ones(length(ind),1);
% 23: R_thalamus
roigroups{23}.name=['R_thalamus']; roigroups{23}.ind=23;
ind=find(raparc==49 & rsuvr>0);
rnewaparc(ind)=23.*ones(length(ind),1);
% 24: R_caudantcing
roigroups{24}.name=['R_caudantcing']; roigroups{24}.ind=24;
ind=find(raparc==2002 & rsuvr>0);
rnewaparc(ind)=24.*ones(length(ind),1);
% 25: R_rostantcing
roigroups{25}.name=['R_rostantcing']; roigroups{25}.ind=25;
ind=find(raparc==2026 & rsuvr>0);
rnewaparc(ind)=25.*ones(length(ind),1);
% 26: R_postcing
roigroups{26}.name=['R_postcing']; roigroups{26}.ind=26;
ind=find(raparc==2023 & rsuvr>0);
rnewaparc(ind)=26.*ones(length(ind),1);
% 27: R_isthmuscing
roigroups{27}.name=['R_isthmuscing']; roigroups{27}.ind=27;
ind=find(raparc==2010 & rsuvr>0);
rnewaparc(ind)=27.*ones(length(ind),1);
% 28: R_insula
roigroups{28}.name=['R_insula']; roigroups{28}.ind=28;
ind=find(raparc==2035 & rsuvr>0);
rnewaparc(ind)=28.*ones(length(ind),1);
% 29: R_inferiortemporal
roigroups{29}.name=['R_inferiortemporal']; roigroups{29}.ind=29;
ind=find(raparc==2009 & rsuvr>0);
rnewaparc(ind)=29.*ones(length(ind),1);
% 30: R_temppole
roigroups{30}.name=['R_temppolel']; roigroups{30}.ind=30;
ind=find(raparc==2033 & rsuvr>0);
rnewaparc(ind)=30.*ones(length(ind),1);
% 31: L_frontalassociationcortex SUPFR
roigroups{31}.name=['L_frontalassociationcortex SUPFR']; roigroups{31}.ind=31;
ind=find(raparc==1028 & rsuvr>0);
rnewaparc(ind)=31.*ones(length(ind),1);
% 32: L_frontalassociationcortex FPORB
roigroups{32}.name=['L_frontalassociationcortex FPORB']; roigroups{32}.ind=32;
ind=find((raparc==1012 | raparc==1014 | raparc==1032) & rsuvr>0);
rnewaparc(ind)=32.*ones(length(ind),1);
% 33: L_frontalassociationcortex MIDFR
roigroups{33}.name=['L_frontalassociationcortex MIDFR']; roigroups{33}.ind=33;
ind=find((raparc==1003 | raparc==1027) & rsuvr>0);
rnewaparc(ind)=33.*ones(length(ind),1);
% 34: L_frontalassociationcortex PARSFR
roigroups{34}.name=['L_frontalassociationcortex PARSFR']; roigroups{34}.ind=34;
ind=find((raparc==1018 | raparc==1019 | raparc==1020) & rsuvr>0);
rnewaparc(ind)=34.*ones(length(ind),1);
% 35: L_caudate
roigroups{35}.name=['L_caudate']; roigroups{35}.ind=35;
ind=find(raparc==11 & rsuvr>0);
rnewaparc(ind)=35.*ones(length(ind),1);
% 36: L_putamen
roigroups{36}.name=['L_putamen']; roigroups{36}.ind=36;
ind=find(raparc==12 & rsuvr>0);
rnewaparc(ind)=36.*ones(length(ind),1);
% 37: L_lateraloccipital
roigroups{37}.name=['L_lateraloccipital']; roigroups{37}.ind=37;
ind=find(raparc==1011 & rsuvr>0);
rnewaparc(ind)=37.*ones(length(ind),1);
% 38: L_parietalsupramarginal
roigroups{38}.name=['L_parietalsupramarginal']; roigroups{38}.ind=38;
ind=find(raparc==1031 & rsuvr>0);
rnewaparc(ind)=38.*ones(length(ind),1);
% 39: L_parietalinferior
roigroups{39}.name=['L_parietalinferior']; roigroups{39}.ind=39;
ind=find(raparc==1008 & rsuvr>0);
rnewaparc(ind)=39.*ones(length(ind),1);
% 40: L_superiortemporal
roigroups{40}.name=['L_superiortemporal']; roigroups{40}.ind=40;
ind=find(raparc==1030 & rsuvr>0);
rnewaparc(ind)=40.*ones(length(ind),1);
% 41: L_pallidum
roigroups{41}.name=['L_pallidum']; roigroups{41}.ind=41;
ind=find(raparc==13 & rsuvr>0);
rnewaparc(ind)=41.*ones(length(ind),1);
% 42: L_parietalsuperior
roigroups{42}.name=['L_parietalsuperior']; roigroups{42}.ind=42;
ind=find(raparc==1029 & rsuvr>0);
rnewaparc(ind)=42.*ones(length(ind),1);
% 43: L_precuneus
roigroups{43}.name=['L_precuneus']; roigroups{43}.ind=43;
ind=find(raparc==1025 & rsuvr>0);
rnewaparc(ind)=43.*ones(length(ind),1);
% 44: L_bankSTS
roigroups{44}.name=['L_bankSTS']; roigroups{44}.ind=44;
ind=find(raparc==1001 & rsuvr>0);
rnewaparc(ind)=44.*ones(length(ind),1);
% 45: L_accumbens
roigroups{45}.name=['L_accumbens']; roigroups{45}.ind=45;
ind=find(raparc==26 & rsuvr>0);
rnewaparc(ind)=45.*ones(length(ind),1);
% 46: L_tranvtemp
roigroups{46}.name=['L_tranvtemp']; roigroups{46}.ind=46;
ind=find(raparc==1034 & rsuvr>0);
rnewaparc(ind)=46.*ones(length(ind),1);
% 47: R_frontalassociationcortex SUPFR
roigroups{47}.name=['R_frontalassociationcortex SUPFR']; roigroups{47}.ind=47;
ind=find(raparc==2028 & rsuvr>0);
rnewaparc(ind)=47.*ones(length(ind),1);
% 48: R_frontalassociationcortex FPORB
roigroups{48}.name=['R_frontalassociationcortex FPORB']; roigroups{48}.ind=48;
ind=find((raparc==2012 | raparc==2014 | raparc==2032) & rsuvr>0);
rnewaparc(ind)=48.*ones(length(ind),1);
% 49: R_frontalassociationcortex MIDFR
roigroups{49}.name=['R_frontalassociationcortex MIDFR']; roigroups{49}.ind=49;
ind=find((raparc==2003 | raparc==2027) & rsuvr>0);
rnewaparc(ind)=49.*ones(length(ind),1);
% 50: R_frontalassociationcortex PARSFR
roigroups{50}.name=['R_frontalassociationcortex PARSFR']; roigroups{50}.ind=50;
ind=find((raparc==2018 | raparc==2019 | raparc==2020) & rsuvr>0);
rnewaparc(ind)=50.*ones(length(ind),1);
% 51: R_caudate
roigroups{51}.name=['R_caudate']; roigroups{51}.ind=51;
ind=find(raparc==50 & rsuvr>0);
rnewaparc(ind)=51.*ones(length(ind),1);
% 52: R_putamen
roigroups{52}.name=['R_putamen']; roigroups{52}.ind=52;
ind=find(raparc==51 & rsuvr>0);
rnewaparc(ind)=52.*ones(length(ind),1);
% 53: R_lateraloccipital
roigroups{53}.name=['R_lateraloccipital']; roigroups{53}.ind=53;
ind=find(raparc==2011 & rsuvr>0);
rnewaparc(ind)=53.*ones(length(ind),1);
% 54: R_parietalsupramarginal
roigroups{54}.name=['R_parietalsupramarginal']; roigroups{54}.ind=54;
ind=find(raparc==2031 & rsuvr>0);
rnewaparc(ind)=54.*ones(length(ind),1);
% 55: R_parietalinferior
roigroups{55}.name=['R_parietalinferior']; roigroups{55}.ind=55;
ind=find(raparc==2008 & rsuvr>0);
rnewaparc(ind)=55.*ones(length(ind),1);
% 56: R_superiortemporal
roigroups{56}.name=['R_superiortemporal']; roigroups{56}.ind=56;
ind=find(raparc==2030 & rsuvr>0);
rnewaparc(ind)=56.*ones(length(ind),1);
% 57: R_pallidum
roigroups{57}.name=['R_pallidum']; roigroups{57}.ind=57;
ind=find(raparc==52 & rsuvr>0);
rnewaparc(ind)=57.*ones(length(ind),1);
% 58: R_parietalsuperior
roigroups{58}.name=['R_parietalsuperior']; roigroups{58}.ind=58;
ind=find(raparc==2029 & rsuvr>0);
rnewaparc(ind)=58.*ones(length(ind),1);
% 59: R_precuneus
roigroups{59}.name=['R_precuneus']; roigroups{59}.ind=59;
ind=find(raparc==2025 & rsuvr>0);
rnewaparc(ind)=59.*ones(length(ind),1);
% 60: R_bankSTS
roigroups{60}.name=['R_bankSTS']; roigroups{60}.ind=60;
ind=find(raparc==2001 & rsuvr>0);
rnewaparc(ind)=60.*ones(length(ind),1);
% 61: R_accumbens
roigroups{61}.name=['R_accumbens']; roigroups{61}.ind=61;
ind=find(raparc==58 & rsuvr>0);
rnewaparc(ind)=61.*ones(length(ind),1);
% 62: R_tranvtemp
roigroups{62}.name=['R_tranvtemp']; roigroups{62}.ind=62;
ind=find(raparc==2034 & rsuvr>0);
rnewaparc(ind)=62.*ones(length(ind),1);
% 63: L_pericalcarine
roigroups{63}.name=['L_pericalcarine']; roigroups{63}.ind=63;
ind=find(raparc==1021 & rsuvr>0);
rnewaparc(ind)=63.*ones(length(ind),1);
% 64: L_postcentral
roigroups{64}.name=['L_postcentral']; roigroups{64}.ind=64;
ind=find(raparc==1022 & rsuvr>0);
rnewaparc(ind)=64.*ones(length(ind),1);
% 65: L_cuneus
roigroups{65}.name=['L_cuneus']; roigroups{65}.ind=65;
ind=find(raparc==1005 & rsuvr>0);
rnewaparc(ind)=65.*ones(length(ind),1);
% 66: L_precentral
roigroups{66}.name=['L_precentral']; roigroups{66}.ind=66;
ind=find(raparc==1024 & rsuvr>0);
rnewaparc(ind)=66.*ones(length(ind),1);
% 67: L_paracentral
roigroups{67}.name=['L_paracentral']; roigroups{67}.ind=67;
ind=find(raparc==1017 & rsuvr>0);
rnewaparc(ind)=67.*ones(length(ind),1);
% 68: R_pericalcarine
roigroups{68}.name=['R_pericalcarine']; roigroups{68}.ind=68;
ind=find(raparc==2021 & rsuvr>0);
rnewaparc(ind)=68.*ones(length(ind),1);
% 69: R_postcentral
roigroups{69}.name=['R_postcentral']; roigroups{69}.ind=69;
ind=find(raparc==2022 & rsuvr>0);
rnewaparc(ind)=69.*ones(length(ind),1);
% 70: R_cuneus
roigroups{70}.name=['R_cuneus']; roigroups{70}.ind=70;
ind=find(raparc==2005 & rsuvr>0);
rnewaparc(ind)=70.*ones(length(ind),1);
% 71: R_precentral
roigroups{71}.name=['R_precentral']; roigroups{71}.ind=71;
ind=find(raparc==2024 & rsuvr>0);
rnewaparc(ind)=71.*ones(length(ind),1);
% 72: R_paracentral
roigroups{72}.name=['R_paracentral']; roigroups{72}.ind=72;
ind=find(raparc==2017 & rsuvr>0);
rnewaparc(ind)=72.*ones(length(ind),1);
% 73: hemispheric white
roigroups{73}.name=['hemispheric white']; roigroups{73}.ind=73;
ind=find((raparc==2 | raparc==41 | raparc==251 | raparc==252 | raparc==253 | raparc==254 | raparc==255) & rsuvr>0);
rnewaparc(ind)=73.*ones(length(ind),1);
% 74: cerebellar white
roigroups{74}.name=['cerebellar white']; roigroups{74}.ind=74;
ind=find((raparc==7 | raparc==46) & rsuvr>0);
rnewaparc(ind)=74.*ones(length(ind),1);
% 75: brainstem
roigroups{75}.name=['brainstem']; roigroups{75}.ind=75;
ind=find(raparc==16 & rsuvr>0);
rnewaparc(ind)=75.*ones(length(ind),1);
% 76: other
roigroups{76}.name=['other']; roigroups{76}.ind=76;
ind=find((raparc==28 | raparc==30 | raparc==60 | ...
    raparc==62 | raparc==77 | raparc==80 | ...
    raparc==85 | raparc==1000 | raparc==1004 | raparc==2000 | ...
    raparc==2004) & rsuvr>0);
rnewaparc(ind)=76.*ones(length(ind),1);
% 77: superior cerebellar gray
roigroups{77}.name=['superior_cerebellar_gray']; roigroups{77}.ind=77;
ind=find((raparc==8 | raparc==47) & rsuvr>0);
rnewaparc(ind)=77.*ones(length(ind),1);
% assign ventricles to 9999, this will be made 0 at the very end
ind=find(raparc==4 | raparc==43 | raparc==5 | raparc==44 | ...
    raparc==14 | raparc==15 | raparc==72 | raparc==24);
rnewaparc(ind)=9999.*ones(length(ind),1);