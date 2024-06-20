%ERP PIGGIE 4 conditions
%2019 05 31
%modified 2021.05.11 for mobile eeg

clear all
clc

% TB = IOPort('OpenSerialPort', 'COM3'); 
% % Read data from the TriggerBox 
% Available = IOPort('BytesAvailable', TB); 
% if(Available > 0)     
%     disp(IOPort('Read', TB, 0, Available)); 
% end
% % Set the port to zero state 0 
% IOPort('Write', TB, uint8(0), 0); 
% pause(0.01); 

cd('C:\Users\Marianna\WORK\ELTE\Lendulet\voice EEG\temp')

startup = 0;

while startup == 0
    
    subjnum=input('V.Sz. száma (egész szám < 150)\n');
    if ~isnumeric(subjnum)
        disp('Számot írj be!')
        continue
    end
    if mod(subjnum,1)~=0
        disp('Egész számot írj be!')
        continue
    end
    if subjnum < 0
        disp('Szám > 0!')
        continue
    end
    if subjnum >= 150
        disp('Szám < 150')
        continue
    end
    resp=0;
    if exist([num2str(subjnum) '_log.mat'],'file')
        while ~ismember(resp,[1 2]) 
            resp=input('V.Sz. létezik. 1=Folytat (utolsó teljes blokktól) 2=Új szám\n');
        end
        switch resp
            case 1
                load([num2str(subjnum) '_log.mat'])
                startup=1;
            case 2
                continue
        end
    else
        startup=1;
        % log file
        log.utolso_tomb = 0;
        log.nev = subjnum;
    end
    
end

%%
SOA = randi([160 260], 1, 320)*10;
log.soa = SOA;
% order of presentations in test
s = [1	81	161	241	2	162	82	242	83	3	243	163	4	84	164	244	165	245	85	5	86	246	6	166	247	7	87	167	8	248	168	88	169	9	89	249	10	90	170	250	91	11	251	171	12	92	252	172	253	13	173	93	14	94	174	254	15	95	175	255	96	256	16	176	17	257	177	97	18	98	178	258	99	19	259	179	20	100	180	260	101	181	261	21	182	262	22	102	23	103	183	263	184	104	24	264	105	25	265	185	26	106	186	266	27	187	107	267	28	268	188	108	269	109	189	29	270	190	30	110	31	111	191	271	192	272	32	112	33	113	193	273	34	114	274	194	35	195	275	115	196	36	116	276	37	277	117	197	118	198	38	278	39	119	199	279	40	200	120	280	201	281	41	121	42	122	282	202	43	123	203	283	124	284	204	44	125	205	285	45	206	46	286	126	47	127	207	287	48	288	128	208	289	49	209	129	50	130	290	210	131	291	51	211	52	292	212	132	53	133	293	213	294	214	134	54	215	55	135	295	56	136	216	296	57	217	137	297	58	298	218	138	299	139	59	219	300	60	220	140	61	141	221	301	222	142	302	62	303	223	143	63	144	304	64	224	65	305	145	225	306	66	226	146	67	147	227	307	68	148	308	228	149	309	229	69	310	150	70	230	71	151	311	231	152	232	312	72	313	233	153	73	314	74	154	234	75	315	235	155	76	156	316	236	77	317	157	237	318	238	78	158	79	159	239	319	160	80	320	240];

log.order=s;
save([num2str(subjnum) '_log'],'log');
fs = 44100;
% fs =48000;


path_to_sounds='C:\Users\Marianna\WORK\ELTE\Lendulet\voice EEG\temp\Stimuli\';

my_sounds={strcat(path_to_sounds,'dog_s007_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s007_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s008_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s008_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s009_grunt_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s010_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s010_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s013_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s017_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s017_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s018_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s018_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s021_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s022_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s022_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s025_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s025_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s029_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s030_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s031_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s031_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s033_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s036_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s036_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s037_yelp_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s045_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s047_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s048_whine_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s049_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s049_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s051_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s051_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s055_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s055_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s057_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s058_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s058_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s059_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s059_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s060_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s060_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s061_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s063_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s065_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s065_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s066_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s067_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s068_whine_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s068_whine_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s069_grunt_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s070_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s070_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s071_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s072_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s073_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s074_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s076_whine_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s078_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s079_whine_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s079_whine_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s080_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s080_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s082_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s083_whine_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s085_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s086_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s088_grunt_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s089_whine_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s090_bark_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s091_bark_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s092_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s092_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s093_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s094_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s094_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s097_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s098_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s099_yelp_2__fade_stereo_44100'),strcat(path_to_sounds,'dog_s100_growl_1__fade_stereo_44100'),strcat(path_to_sounds,'dog_s100_growl_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s006_sex_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s007_sex_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s007_sex_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s008_sex_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s008_sex_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s009_sex_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s009_sex_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s014_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s014_cough_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s015_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s015_cough_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s018_cry_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s020_yawn_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s020_yawn_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s022_cry_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s023_cry_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s024_cry_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s026_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s026_cough_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s027_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s027_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s030_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s031_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s034_sigh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s035_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s035_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s037_laugh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s038_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s038_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s041_cry_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s041_cry_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s042_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s043_laugh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s043_laugh_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s044_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s046_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s048_laugh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s049_shout_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s050_sigh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s052_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s053_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s053_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s054_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s054_human_moan_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s057_sigh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s059_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s059_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s060_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s060_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s061_retch_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s064_sigh_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s067_sigh_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s068_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s070_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s070_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s071_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s072_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s073_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s073_cough_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s074_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s076_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s076_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s077_cough_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s077_cough_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s079_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s079_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s080_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s080_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s081_general_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s081_general_2__fade_stereo_44100'),strcat(path_to_sounds,'human_s082_yawn_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s083_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s084_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s085_shout_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s086_shout_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s087_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s089_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s095_shout_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s096_cry_1__fade_stereo_44100'),strcat(path_to_sounds,'human_s097_human_moan_1__fade_stereo_44100'),strcat(path_to_sounds,'kornyezet_101_2_fade'),strcat(path_to_sounds,'kornyezet_107_2_fade'),strcat(path_to_sounds,'kornyezet_109__fade'),strcat(path_to_sounds,'kornyezet_111__fade'),strcat(path_to_sounds,'kornyezet_118__fade'),strcat(path_to_sounds,'kornyezet_11__fade'),strcat(path_to_sounds,'kornyezet_121__fade'),strcat(path_to_sounds,'kornyezet_129__fade'),strcat(path_to_sounds,'kornyezet_136__fade'),strcat(path_to_sounds,'kornyezet_13__fade'),strcat(path_to_sounds,'kornyezet_140__fade'),strcat(path_to_sounds,'kornyezet_143__fade'),strcat(path_to_sounds,'kornyezet_149__fade'),strcat(path_to_sounds,'kornyezet_14__fade'),strcat(path_to_sounds,'kornyezet_151__fade'),strcat(path_to_sounds,'kornyezet_153_2_fade'),strcat(path_to_sounds,'kornyezet_158__fade'),strcat(path_to_sounds,'kornyezet_159__fade'),strcat(path_to_sounds,'kornyezet_161__fade'),strcat(path_to_sounds,'kornyezet_162_2_fade'),strcat(path_to_sounds,'kornyezet_164__fade'),strcat(path_to_sounds,'kornyezet_168__fade'),strcat(path_to_sounds,'kornyezet_171__fade'),strcat(path_to_sounds,'kornyezet_172__fade'),strcat(path_to_sounds,'kornyezet_175_2_fade'),strcat(path_to_sounds,'kornyezet_176_2_fade'),strcat(path_to_sounds,'kornyezet_178__fade'),strcat(path_to_sounds,'kornyezet_179__fade'),strcat(path_to_sounds,'kornyezet_183__fade'),strcat(path_to_sounds,'kornyezet_184__fade'),strcat(path_to_sounds,'kornyezet_187__fade'),strcat(path_to_sounds,'kornyezet_18__fade'),strcat(path_to_sounds,'kornyezet_192_2_fade'),strcat(path_to_sounds,'kornyezet_194__fade'),strcat(path_to_sounds,'kornyezet_195__fade'),strcat(path_to_sounds,'kornyezet_199__fade'),strcat(path_to_sounds,'kornyezet_201__fade'),strcat(path_to_sounds,'kornyezet_21__fade'),strcat(path_to_sounds,'kornyezet_22__fade'),strcat(path_to_sounds,'kornyezet_28__fade'),strcat(path_to_sounds,'kornyezet_29__fade'),strcat(path_to_sounds,'kornyezet_2__fade'),strcat(path_to_sounds,'kornyezet_30__fade'),strcat(path_to_sounds,'kornyezet_31__fade'),strcat(path_to_sounds,'kornyezet_32__fade'),strcat(path_to_sounds,'kornyezet_33__fade'),strcat(path_to_sounds,'kornyezet_34__fade'),strcat(path_to_sounds,'kornyezet_36__fade'),strcat(path_to_sounds,'kornyezet_38__fade'),strcat(path_to_sounds,'kornyezet_39__fade'),strcat(path_to_sounds,'kornyezet_40_2_fade'),strcat(path_to_sounds,'kornyezet_41__fade'),strcat(path_to_sounds,'kornyezet_42__fade'),strcat(path_to_sounds,'kornyezet_43__fade'),strcat(path_to_sounds,'kornyezet_46__fade'),strcat(path_to_sounds,'kornyezet_52__fade'),strcat(path_to_sounds,'kornyezet_54__fade'),strcat(path_to_sounds,'kornyezet_55__fade'),strcat(path_to_sounds,'kornyezet_63__fade'),strcat(path_to_sounds,'kornyezet_64__fade'),strcat(path_to_sounds,'kornyezet_65__fade'),strcat(path_to_sounds,'kornyezet_66__fade'),strcat(path_to_sounds,'kornyezet_67__fade'),strcat(path_to_sounds,'kornyezet_68__fade'),strcat(path_to_sounds,'kornyezet_6__fade'),strcat(path_to_sounds,'kornyezet_73__fade'),strcat(path_to_sounds,'kornyezet_75__fade'),strcat(path_to_sounds,'kornyezet_77__fade'),strcat(path_to_sounds,'kornyezet_7__fade'),strcat(path_to_sounds,'kornyezet_85__fade'),strcat(path_to_sounds,'kornyezet_86__fade'),strcat(path_to_sounds,'kornyezet_87__fade'),strcat(path_to_sounds,'kornyezet_88_2_fade'),strcat(path_to_sounds,'kornyezet_90__fade'),strcat(path_to_sounds,'kornyezet_91__fade'),strcat(path_to_sounds,'kornyezet_92__fade'),strcat(path_to_sounds,'kornyezet_93__fade'),strcat(path_to_sounds,'kornyezet_95__fade'),strcat(path_to_sounds,'kornyezet_97__fade'),strcat(path_to_sounds,'kornyezet_98__fade'),strcat(path_to_sounds,'pBorso_holdingcomplain_12s_28112018_46_2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_holdingcomplain_12s_28112018_47_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_holdingcomplain_12s_28112018_48_2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_holdingcomplain_12s_28112018_49_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_holdingcomplain_12s_28112018_50_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_pettingcomplains_5s_28112018_51_2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_pettingcomplains_5s_28112018_52_mono_fade_stereo_44100'),strcat(path_to_sounds,'pBorso_Pigrecording_grunts_contactseeking_video15_04_5_4s_30012019_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_complains_11_0547ss_video4_03min_218_75_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_complains_11_0547ss_video4_03min_218_76_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_complains_11_0547ss_video4_03min_218_77_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_complains_11_0547ss_video4_03min_218_78_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_complains_11_0547ss_video4_03min_218_79_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_4_7s_video_2min_218_55_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_4_7s_video_2min_218_57_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_4_9s_videomin4_15_58_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_4_9s_videomin4_15_59_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_4_9s_videomin4_15_60_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_5_9s_video1_37min_218_62_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_64_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_65_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_66_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_67_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_68_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_20190503_Complain_7_9s_video2min_218_69_mono_fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_17_2_videomin_21_10_10022019_7__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_23_1_videomin7_35_07022019_12__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_23_1_videomin7_35_07022019_6__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_23_1_videomin7_35_07022019_7__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_31_5_videomin_26_06_10022019_11__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_31_5_videomin_26_06_10022019_14__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_31_5_videomin_26_06_10022019_18__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_31_5_videomin_26_06_10022019_8__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_13__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_14__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_15__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_6__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_8__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_5_videomin_15_10_10022019_9__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_6_videomin_24_30_10022019_10__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_33_6_videomin_24_30_10022019_7__fade_stereo_44100'),strcat(path_to_sounds,'pManka_Pigvoicerecording_squeakholding_39_5_videomin_9_55_07022019_16__fade_stereo_44100'),strcat(path_to_sounds,'pMeaty_begging_food_deepgrunt_2_4s_04122018_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pMeaty_begging_food_deepgrunt_2_4s_04122018_2__mono_fade_stereo_44100'),strcat(path_to_sounds,'pMeaty_begging_food_deepgrunt_4_5s_04122018_1__mono_fade_stereo_44100'),strcat(path_to_sounds,'pMeaty_begging_food_deepgrunt_4_5s_04122018_2__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_2_videomin6_04_27012019_18__2_fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_2_videomin6_04_27012019_19__fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_2_videomin6_04_27012019_21__2_fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_2_videomin6_04_27012019_24__fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_2_videomin6_04_27012019_3__2_fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__19_7_videomin5_35_27012019_8__fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__22_4_videomin4_33_22012019_13__fade_stereo_44100'),strcat(path_to_sounds,'pOdi_Pigvoicerecordig_squeakholding__22_4_videomin4_33_22012019_5__fade_stereo_44100'),strcat(path_to_sounds,'pSari_Begging_food_grunt_3_37s_video_min11_58_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Begging_food_grunt_7_29s_video_min11_50_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_11__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_14__mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_16__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_17__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_18__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_19__mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_3__mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_6__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_17_29s_video_min12_57_9__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pSari_Holding_complain_7_25s_video_min13_42_1__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_begging_food_grunts_video31_25min_19s_13012019_5__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_begging_food_grunts_video31_25min_19s_13012019_6__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_begging_food_grunts_video31_25min_19s_13012019_7__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_exploration_grunts_video27_08min_12_32s_13012019_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video21_39min_8_57s_13012019_1__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video21_39min_8_57s_13012019_5__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video21_39min_8_57s_13012019_6__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video21_55min_12_79s_13012019_6__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video22min_12_90s_13012019_1__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video22min_12_90s_13012019_2__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video22min_12_90s_13012019_4__2_mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video22min_12_90s_13012019_5__mono_fade_stereo_44100'),strcat(path_to_sounds,'pVargi_petting_complains_video22min_12_90s_13012019_6__mono_fade_stereo_44100')};
% my_sounds={strcat(path_to_sounds,'dog_s007_bark_1__fade_stereo_48000')};
    
log.sounds=my_sounds;
save([num2str(subjnum) '_log'],'log');

% test sounds
sndlen = []; % list for sound duration
%i=1;
for i=1:length(my_sounds) % number of sounds in my_sounds
    %[sound, freq, nbits] = wavread([my_sounds{i} '.wav']);
    [sound, freq] = audioread([my_sounds{i} '.wav']);
    %[sound, freq] = audioread([my_sounds{i} '_44100.wav']);
    if freq ~= fs
        throw(MException('Audio:Loading','Sampling rate mismatch!'))
    end
    
    if size(sound,2) == 1 % mono
        wavedata = [sound sound]' ;
    elseif size(sound,2) == 2 % stereo
        wavedata = sound' ;
    end
    sndlen(i)=length(wavedata)/fs; % sound lengths in seconds
    
    wavedata_s{i}=wavedata; %[wavedata1; wavedata2];
    
end

%1. Initialize - check if lab machine has a sound card!!!
InitializePsychSound
% pahandle = PsychPortAudio('Open', [] , 1, [], fs, 2, [], [], [1 2]); 
pahandle = PsychPortAudio('Open', 3 , 1, [], fs, 2, [], [], [0 1]); % 'MME' hangszóró

% ioObj = io64;
% status = io64(ioObj);
% 
% out_address = 888; % a parallel port kodja

WaitSecs(1);
disp(['Passive oddball' ]);

disp('Gombnyomasra kezdodik')
pause
WaitSecs(3)

% test sounds
wavehandle(1)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{1});
wavehandle(2)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{2});
wavehandle(3)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{3});
wavehandle(4)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{4});
wavehandle(5)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{5});
wavehandle(6)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{6});
wavehandle(7)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{7});
wavehandle(8)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{8});
wavehandle(9)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{9});
wavehandle(10)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{10});
wavehandle(11)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{11});
wavehandle(12)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{12});
wavehandle(13)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{13});
wavehandle(14)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{14});
wavehandle(15)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{15});
wavehandle(16)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{16});
wavehandle(17)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{17});
wavehandle(18)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{18});
wavehandle(19)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{19});
wavehandle(20)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{21});
wavehandle(21)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{21});
wavehandle(22)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{22});
wavehandle(23)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{23});
wavehandle(24)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{24});
wavehandle(25)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{25});
wavehandle(26)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{26});
wavehandle(27)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{27});
wavehandle(28)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{28});
wavehandle(29)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{29});
wavehandle(30)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{30});
wavehandle(31)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{31});
wavehandle(32)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{32});
wavehandle(33)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{33});
wavehandle(34)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{34});
wavehandle(35)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{35});
wavehandle(36)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{36});
wavehandle(37)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{37});
wavehandle(38)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{38});
wavehandle(39)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{39});
wavehandle(40)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{40});
wavehandle(41)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{41});
wavehandle(42)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{42});
wavehandle(43)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{43});
wavehandle(44)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{44});
wavehandle(45)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{45});
wavehandle(46)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{46});
wavehandle(47)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{47});
wavehandle(48)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{48});
wavehandle(49)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{49});
wavehandle(50)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{50});
wavehandle(51)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{51});
wavehandle(52)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{52});
wavehandle(53)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{53});
wavehandle(54)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{54});
wavehandle(55)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{55});
wavehandle(56)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{56});
wavehandle(57)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{57});
wavehandle(58)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{58});
wavehandle(59)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{59});
wavehandle(60)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{60});
wavehandle(61)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{61});
wavehandle(62)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{62});
wavehandle(63)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{63});
wavehandle(64)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{64});
wavehandle(65)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{65});
wavehandle(66)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{66});
wavehandle(67)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{67});
wavehandle(68)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{68});
wavehandle(69)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{69});
wavehandle(70)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{70});
wavehandle(71)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{71});
wavehandle(72)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{72});
wavehandle(73)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{73});
wavehandle(74)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{74});
wavehandle(75)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{75});
wavehandle(76)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{76});
wavehandle(77)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{77});
wavehandle(78)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{78});
wavehandle(79)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{79});
wavehandle(80)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{80});
wavehandle(81)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{81});
wavehandle(82)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{82});
wavehandle(83)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{83});
wavehandle(84)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{84});
wavehandle(85)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{85});
wavehandle(86)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{86});
wavehandle(87)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{87});
wavehandle(88)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{88});
wavehandle(89)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{89});
wavehandle(90)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{90});
wavehandle(91)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{91});
wavehandle(92)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{92});
wavehandle(93)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{93});
wavehandle(94)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{94});
wavehandle(95)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{95});
wavehandle(96)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{96});
wavehandle(97)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{97});
wavehandle(98)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{98});
wavehandle(99)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{99});
wavehandle(100)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{100});
wavehandle(101)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{101});
wavehandle(102)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{102});
wavehandle(103)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{103});
wavehandle(104)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{104});
wavehandle(105)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{105});
wavehandle(106)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{106});
wavehandle(107)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{107});
wavehandle(108)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{108});
wavehandle(109)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{109});
wavehandle(110)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{110});
wavehandle(111)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{111});
wavehandle(112)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{112});
wavehandle(113)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{113});
wavehandle(114)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{114});
wavehandle(115)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{115});
wavehandle(116)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{116});
wavehandle(117)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{117});
wavehandle(118)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{118});
wavehandle(119)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{119});
wavehandle(120)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{120});
wavehandle(121)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{121});
wavehandle(122)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{122});
wavehandle(123)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{123});
wavehandle(124)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{124});
wavehandle(125)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{125});
wavehandle(126)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{126});
wavehandle(127)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{127});
wavehandle(128)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{128});
wavehandle(129)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{129});
wavehandle(130)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{130});
wavehandle(131)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{131});
wavehandle(132)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{132});
wavehandle(133)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{133});
wavehandle(134)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{134});
wavehandle(135)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{135});
wavehandle(136)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{136});
wavehandle(137)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{137});
wavehandle(138)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{138});
wavehandle(139)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{139});
wavehandle(140)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{140});
wavehandle(141)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{141});
wavehandle(142)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{142});
wavehandle(143)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{143});
wavehandle(144)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{144});
wavehandle(145)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{145});
wavehandle(146)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{146});
wavehandle(147)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{147});
wavehandle(148)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{148});
wavehandle(149)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{149});
wavehandle(150)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{150});
wavehandle(151)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{151});
wavehandle(152)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{152});
wavehandle(153)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{153});
wavehandle(154)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{154});
wavehandle(155)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{155});
wavehandle(156)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{156});
wavehandle(157)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{157});
wavehandle(158)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{158});
wavehandle(159)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{159});
wavehandle(160)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{160});
wavehandle(161)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{161});
wavehandle(162)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{162});
wavehandle(163)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{163});
wavehandle(164)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{164});
wavehandle(165)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{165});
wavehandle(166)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{166});
wavehandle(167)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{167});
wavehandle(168)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{168});
wavehandle(169)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{169});
wavehandle(170)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{170});
wavehandle(171)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{171});
wavehandle(172)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{172});
wavehandle(173)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{173});
wavehandle(174)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{174});
wavehandle(175)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{175});
wavehandle(176)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{176});
wavehandle(177)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{177});
wavehandle(178)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{178});
wavehandle(179)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{179});
wavehandle(180)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{180});
wavehandle(181)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{181});
wavehandle(182)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{182});
wavehandle(183)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{183});
wavehandle(184)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{184});
wavehandle(185)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{185});
wavehandle(186)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{186});
wavehandle(187)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{187});
wavehandle(188)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{188});
wavehandle(189)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{189});
wavehandle(190)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{190});
wavehandle(191)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{191});
wavehandle(192)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{192});
wavehandle(193)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{193});
wavehandle(194)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{194});
wavehandle(195)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{195});
wavehandle(196)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{196});
wavehandle(197)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{197});
wavehandle(198)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{198});
wavehandle(199)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{199});
wavehandle(200)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{200});
wavehandle(201)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{201});
wavehandle(202)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{202});
wavehandle(203)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{203});
wavehandle(204)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{204});
wavehandle(205)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{205});
wavehandle(206)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{206});
wavehandle(207)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{207});
wavehandle(208)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{208});
wavehandle(209)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{209});
wavehandle(210)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{210});
wavehandle(211)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{211});
wavehandle(212)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{212});
wavehandle(213)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{213});
wavehandle(214)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{214});
wavehandle(215)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{215});
wavehandle(216)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{216});
wavehandle(217)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{217});
wavehandle(218)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{218});
wavehandle(219)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{219});
wavehandle(220)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{220});
wavehandle(221)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{221});
wavehandle(222)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{222});
wavehandle(223)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{223});
wavehandle(224)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{224});
wavehandle(225)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{225});
wavehandle(226)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{226});
wavehandle(227)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{227});
wavehandle(228)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{228});
wavehandle(229)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{229});
wavehandle(230)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{230});
wavehandle(231)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{231});
wavehandle(232)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{232});
wavehandle(233)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{233});
wavehandle(234)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{234});
wavehandle(235)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{235});
wavehandle(236)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{236});
wavehandle(237)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{237});
wavehandle(238)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{238});
wavehandle(239)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{239});
wavehandle(240)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{240});
wavehandle(241)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{241});
wavehandle(242)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{242});
wavehandle(243)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{243});
wavehandle(244)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{244});
wavehandle(245)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{245});
wavehandle(246)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{246});
wavehandle(247)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{247});
wavehandle(248)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{248});
wavehandle(249)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{249});
wavehandle(250)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{250});
wavehandle(251)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{251});
wavehandle(252)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{252});
wavehandle(253)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{253});
wavehandle(254)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{254});
wavehandle(255)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{255});
wavehandle(256)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{256});
wavehandle(257)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{257});
wavehandle(258)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{258});
wavehandle(259)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{259});
wavehandle(260)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{260});
wavehandle(261)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{261});
wavehandle(262)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{262});
wavehandle(263)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{263});
wavehandle(264)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{264});
wavehandle(265)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{265});
wavehandle(266)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{266});
wavehandle(267)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{267});
wavehandle(268)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{268});
wavehandle(269)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{269});
wavehandle(270)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{270});
wavehandle(271)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{271});
wavehandle(272)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{272});
wavehandle(273)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{273});
wavehandle(274)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{274});
wavehandle(275)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{275});
wavehandle(276)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{276});
wavehandle(277)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{277});
wavehandle(278)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{278});
wavehandle(279)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{279});
wavehandle(280)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{280});
wavehandle(281)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{281});
wavehandle(282)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{282});
wavehandle(283)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{283});
wavehandle(284)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{284});
wavehandle(285)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{285});
wavehandle(286)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{286});
wavehandle(287)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{287});
wavehandle(288)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{288});
wavehandle(289)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{289});
wavehandle(290)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{290});
wavehandle(291)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{291});
wavehandle(292)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{292});
wavehandle(293)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{293});
wavehandle(294)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{294});
wavehandle(295)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{295});
wavehandle(296)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{296});
wavehandle(297)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{297});
wavehandle(298)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{298});
wavehandle(299)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{299});
wavehandle(300)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{300});
wavehandle(301)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{301});
wavehandle(302)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{302});
wavehandle(303)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{303});
wavehandle(304)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{304});
wavehandle(305)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{305});
wavehandle(306)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{306});
wavehandle(307)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{307});
wavehandle(308)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{308});
wavehandle(309)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{309});
wavehandle(310)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{310});
wavehandle(311)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{311});
wavehandle(312)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{312});
wavehandle(313)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{313});
wavehandle(314)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{314});
wavehandle(315)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{315});
wavehandle(316)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{316});
wavehandle(317)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{317});
wavehandle(318)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{318});
wavehandle(319)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{319});
wavehandle(320)  = PsychPortAudio('CreateBuffer', pahandle, wavedata_s{320});

% test
PsychPortAudio('FillBuffer', pahandle, wavehandle(s(1)));
    
for seq_cnt=1:length(s)
    t0 = GetSecs();
    

    PsychPortAudio('Start', pahandle, 1, 0, 1);
     %Paralel port
     io64(ioObj,out_address,s(1,seq_cnt))
     WaitSecs(0.005);
     io64(ioObj,out_address,0);

% %% triggers
% % Read data from the TriggerBox 
% Available = IOPort('BytesAvailable', TB); 
% if(Available > 0)     
%     disp(IOPort('Read', TB, 0, Available)); 
% end
% 
% % Set Bit 0 (Pin 2 of the Output(to Amp) connector) 
% IOPort('Write', TB, uint8(seq_cnt), 0); % change seq_cnt to different
% pause(0.01); 
% % Read data from the TriggerBox 
% Available = IOPort('BytesAvailable', TB); 
% if(Available > 0)     
%     disp(IOPort('Read', TB, 0, Available)); 
% end
% % Reset the port to zero state 0 
% IOPort('Write', TB, uint8(0), 0); 
% pause(0.01); 
% 
% % Read data from the TriggerBox 
% Available = IOPort('BytesAvailable', TB); 
% if(Available > 0)     
%     disp(IOPort('Read', TB, 0, Available)); 
% end

    
    while GetSecs() - t0 < sndlen(s(seq_cnt))+0.5
       % WaitSecs(0.005);
    end
    PsychPortAudio('Stop', pahandle);
    
    dt = t0 + (SOA(seq_cnt)/1000);
    
    
    while dt>GetSecs()
        WaitSecs(0.001);
    end

    
    if seq_cnt<length(s) % buffer is filled with next sound 
        PsychPortAudio('FillBuffer', pahandle, wavehandle(s(1,seq_cnt+1)));
    end
     %WaitSecs(0.05);
    
end

% % Reset the port (i.e. bit 0 to 7) to its resting state 255 
% IOPort('Write', TB, uint8(255), 0); 
% pause(0.01); 
% % Read data from the TriggerBox 
% Available = IOPort('BytesAvailable', TB); 
% if(Available > 0)     
%     disp(IOPort('Read', TB, 0, Available)); 
% end
% % Then disconnect/close the serial port object from the serial port 
% IOPort('Close', TB);