C SVERBS-	SIMPLE VERBS PROCESSOR
C	ALL VERBS IN THIS ROUTINE MUST BE INDEPENDANT
C	OF OBJECT ACTIONS
C
C COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142
C ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED
C WRITTEN BY R. M. SUPNIK
C
C DECLARATIONS
C
	LOGICAL FUNCTION SVERBS(RI)
	IMPLICIT INTEGER (A-Z)
	LOGICAL MOVETO,YESNO
	LOGICAL RMDESC
	LOGICAL QOPEN
	LOGICAL FINDXT,QHERE,F
	INTEGER JOKES(25)
	LOGICAL*1 ANSSTR(78)
	LOGICAL*1 P1(6),P2(6),CH(6)
	INTEGER ANSWER(28)
C
C PARSER OUTPUT
C
	LOGICAL PRSWON
	COMMON /PRSVEC/ PRSA,PRSI,PRSO,PRSWON,PRSCON
C
C GAME STATE
C
	LOGICAL TELFLG
	COMMON /PLAY/ WINNER,HERE,TELFLG
	COMMON /STATE/ MOVES,DEATHS,RWSCOR,MXSCOR,MXLOAD,
	1	LTSHFT,BLOC,MUNGRM,HS,EGSCOR,EGMXSC
C
C SCREEN OF LIGHT
C
	COMMON /SCREEN/ FROMDR,SCOLRM,SCOLAC
	COMMON /SCREEN/ SCOLDR(8),SCOLWL(12)
C
C MISCELLANEOUS VARIABLES
C
	LOGICAL*1 INBUF
	COMMON /INPUT/ INLNT,INBUF(78)
	COMMON /VERS/ VMAJ,VMIN,VEDIT
	COMMON /CHAN/ INPCH,OUTCH,DBCH
C
C ROOMS
C
	COMMON /ROOMS/ RLNT,RDESC2,RDESC1(200),REXIT(200),
	1	RACTIO(200),RVAL(200),RFLAG(200)
	INTEGER RRAND(200)
	EQUIVALENCE (RVAL,RRAND)
C
	COMMON /RFLAG/ RSEEN,RLIGHT,RLAND,RWATER,RAIR,
	1	RSACRD,RFILL,RMUNG,RBUCK,RHOUSE,RNWALL,REND
C
	COMMON /RINDEX/ WHOUS,LROOM,CELLA
	COMMON /RINDEX/ MTROL,MAZE1	
	COMMON /RINDEX/ MGRAT,MAZ15	
	COMMON /RINDEX/ FORE1,FORE3,CLEAR,RESER
	COMMON /RINDEX/ STREA,EGYPT,ECHOR
	COMMON /RINDEX/ TSHAF	
	COMMON /RINDEX/ BSHAF,MMACH,DOME,MTORC
	COMMON /RINDEX/ CAROU	
	COMMON /RINDEX/ RIDDL,LLD2,TEMP1,TEMP2,MAINT
	COMMON /RINDEX/ BLROO,TREAS,RIVR1,RIVR2,RIVR3,MCYCL
	COMMON /RINDEX/ RIVR4,RIVR5,FCHMP,FALLS,MBARR
	COMMON /RINDEX/ MRAIN,POG,VLBOT,VAIR1,VAIR2,VAIR3,VAIR4
	COMMON /RINDEX/ LEDG2,LEDG3,LEDG4,MSAFE,CAGER
	COMMON /RINDEX/ CAGED,TWELL,BWELL,ALICE,ALISM,ALITR
	COMMON /RINDEX/ MTREE,BKENT,BKVW,BKTWI,BKVAU,BKBOX
	COMMON /RINDEX/ CRYPT,TSTRS,MRANT,MREYE
	COMMON /RINDEX/ MRA,MRB,MRC,MRG,MRD,FDOOR
	COMMON /RINDEX/ MRAE,MRCE,MRCW,MRGE,MRGW,MRDW,INMIR
	COMMON /RINDEX/ SCORR,NCORR,PARAP,CELL,PCELL,NCELL
	COMMON /RINDEX/ CPANT,CPOUT,CPUZZ
C
C EXITS
C
	COMMON /EXITS/ XLNT,TRAVEL(900)
C
	COMMON /CURXT/ XTYPE,XROOM1,XSTRNG,XACTIO,XOBJ
	EQUIVALENCE (XFLAG,XOBJ)
C
	COMMON /XPARS/ XRMASK,XDMASK,XFMASK,XFSHFT,XASHFT,
	1	XELNT(4),XNORM,XNO,XCOND,XDOOR,XLFLAG
C
	COMMON /XSRCH/ XMIN,XMAX,XDOWN,XUP,
	1	XNORTH,XSOUTH,XENTER,XEXIT,XEAST,XWEST
C
C OBJECTS
C
	COMMON /OBJCTS/ OLNT,ODESC1(220),ODESC2(220),ODESCO(220),
	1	OACTIO(220),OFLAG1(220),OFLAG2(220),OFVAL(220),
	2	OTVAL(220),OSIZE(220),OCAPAC(220),OROOM(220),
	3	OADV(220),OCAN(220),OREAD(220)
C
	COMMON /OFLAGS/ VISIBT,READBT,TAKEBT,DOORBT,TRANBT,FOODBT,
	1	NDSCBT,DRNKBT,CONTBT,LITEBT,VICTBT,BURNBT,FLAMBT,
	2	TOOLBT,TURNBT,ONBT
	COMMON /OFLAGS/ FINDBT,SLEPBT,SCRDBT,TIEBT,CLMBBT,ACTRBT,
	1	WEAPBT,FITEBT,VILLBT,STAGBT,TRYBT,NOCHBT,OPENBT,
	2	TCHBT,VEHBT,SCHBT
C
	COMMON /OINDEX/ GARLI,FOOD,GUNK,COAL,MACHI,DIAMO,TCASE,BOTTL
	COMMON /OINDEX/ WATER,ROPE,KNIFE,SWORD,LAMP,BLAMP,RUG
	COMMON /OINDEX/	LEAVE,TROLL,AXE
	COMMON /OINDEX/ RKNIF,KEYS,ICE,BAR
	COMMON /OINDEX/ COFFI,TORCH,TBASK,FBASK,IRBOX
	COMMON /OINDEX/ GHOST,TRUNK,BELL,BOOK,CANDL
	COMMON /OINDEX/ MATCH,TUBE,PUTTY,WRENC,SCREW,CYCLO,CHALI
	COMMON /OINDEX/ THIEF,STILL,WINDO,GRATE,DOOR
	COMMON /OINDEX/ HPOLE,LEAK,RBUTT,RAILI
	COMMON /OINDEX/ POT,STATU,IBOAT,DBOAT,PUMP,RBOAT
	COMMON /OINDEX/ STICK,BUOY,SHOVE,BALLO,RECEP,GUANO
	COMMON /OINDEX/ BROPE,HOOK1,HOOK2,SAFE,SSLOT,BRICK,FUSE
	COMMON /OINDEX/ GNOME,BLABE,DBALL,TOMB
	COMMON /OINDEX/ LCASE,CAGE,RCAGE,SPHER,SQBUT
	COMMON /OINDEX/ FLASK,POOL,SAFFR,BUCKE,ECAKE,ORICE,RDICE,BLICE
	COMMON /OINDEX/ ROBOT,FTREE,BILLS,PORTR,SCOL,ZGNOM
	COMMON /OINDEX/ EGG,BEGG,BAUBL,CANAR,BCANA
	COMMON /OINDEX/ YLWAL,RDWAL,PINDR,RBEAM
	COMMON /OINDEX/ ODOOR,QDOOR,CDOOR,NUM1,NUM8
	COMMON /OINDEX/ WARNI,CSLIT,GCARD,STLDR
	COMMON /OINDEX/ HANDS,WALL,LUNGS,SAILO,AVIAT,TEETH
	COMMON /OINDEX/ ITOBJ,EVERY,VALUA,OPLAY,WNORT,GWATE,MASTER
C
C CLOCK INTERRUPTS
C
	LOGICAL*1 CFLAG
	COMMON /CEVENT/ CLNT,CTICK(25),CACTIO(25),CFLAG(25)
C
	COMMON /CINDEX/ CEVCUR,CEVMNT,CEVLNT,CEVMAT,CEVCND,
	1	CEVBAL,CEVBRN,CEVFUS,CEVLED,CEVSAF,CEVVLG,
	2	CEVGNO,CEVBUC,CEVSPH,CEVEGH,
	3	CEVFOR,CEVSCL,CEVZGI,CEVZGO,CEVSTE,
	5	CEVMRS,CEVPIN,CEVINQ,CEVFOL

C
C ADVENTURERS
C
	COMMON /ADVS/ ALNT,AROOM(4),ASCORE(4),AVEHIC(4),
	1	AOBJ(4),AACTIO(4),ASTREN(4),AFLAG(4)
C
	COMMON /AINDEX/ PLAYER,AROBOT,AMASTR
C
C VERBS
C
	COMMON /VINDEX/ CINTW,DEADXW,FRSTQW,INXW,OUTXW
	COMMON /VINDEX/ WALKIW,FIGHTW,FOOW
	COMMON /VINDEX/ MELTW,READW,INFLAW,DEFLAW,ALARMW,EXORCW
	COMMON /VINDEX/ PLUGW,KICKW,WAVEW,RAISEW,LOWERW,RUBW
	COMMON /VINDEX/ PUSHW,UNTIEW,TIEW,TIEUPW,TURNW,BREATW
	COMMON /VINDEX/ KNOCKW,LOOKW,EXAMIW,SHAKEW,MOVEW,TRNONW,TRNOFW
	COMMON /VINDEX/ OPENW,CLOSEW,FINDW,WAITW,SPINW,BOARDW,UNBOAW,TAKEW
	COMMON /VINDEX/ INVENW,FILLW,EATW,DRINKW,BURNW
	COMMON /VINDEX/ MUNGW,KILLW,ATTACW,SWINGW
	COMMON /VINDEX/ WALKW,TELLW,PUTW,DROPW,GIVEW,POURW,THROWW
	COMMON /VINDEX/ DIGW,LEAPW,STAYW,FOLLOW
	COMMON /VINDEX/ HELLOW,LOOKIW,LOOKUW,PUMPW,WINDW
	COMMON /VINDEX/ CLMBW,CLMBUW,CLMBDW,TRNTOW
C
C FLAGS
C
	LOGICAL*1 FLAGS(46)
	EQUIVALENCE (FLAGS(1),TROLLF)
	LOGICAL*1 TROLLF,CAGESF,BUCKTF,CAROFF,CAROZF,LWTIDF
	LOGICAL*1 DOMEF,GLACRF,ECHOF,RIDDLF,LLDF,CYCLOF
	LOGICAL*1 MAGICF,LITLDF,SAFEF,GNOMEF,GNODRF,MIRRMF
	LOGICAL*1 EGYPTF,ONPOLF,BLABF,BRIEFF,SUPERF,BUOYF
	LOGICAL*1 GRUNLF,GATEF,RAINBF,CAGETF,EMPTHF,DEFLAF
	LOGICAL*1 GLACMF,FROBZF,ENDGMF,BADLKF,THFENF,SINGSF
	LOGICAL*1 MRPSHF,MROPNF,WDOPNF,MR1F,MR2F,INQSTF
	LOGICAL*1 FOLLWF,SPELLF,CPOUTF,CPUSHF
	COMMON /FINDEX/ TROLLF,CAGESF,BUCKTF,CAROFF,CAROZF,LWTIDF,
	1	DOMEF,GLACRF,ECHOF,RIDDLF,LLDF,CYCLOF,
	2	MAGICF,LITLDF,SAFEF,GNOMEF,GNODRF,MIRRMF,
	3	EGYPTF,ONPOLF,BLABF,BRIEFF,SUPERF,BUOYF,
	4	GRUNLF,GATEF,RAINBF,CAGETF,EMPTHF,DEFLAF,
	5	GLACMF,FROBZF,ENDGMF,BADLKF,THFENF,SINGSF,
	6	MRPSHF,MROPNF,WDOPNF,MR1F,MR2F,INQSTF,
	7	FOLLWF,SPELLF,CPOUTF,CPUSHF
	COMMON /FINDEX/ BTIEF,BINFF
	COMMON /FINDEX/ RVMNT,RVCLR,RVCYC,RVSND,RVGUA
	COMMON /FINDEX/ ORRUG,ORCAND,ORMTCH,ORLAMP
	COMMON /FINDEX/ MDIR,MLOC,POLEUF
	COMMON /FINDEX/ QUESNO,NQATT,CORRCT
	COMMON /FINDEX/ LCELL,PNUMB,ACELL,DCELL,CPHERE
C
C FUNCTIONS AND DATA
C
	QOPEN(R)=(OFLAG2(R).AND.OPENBT).NE.0
	DATA MXNOP/39/,MXJOKE/64/
	DATA JOKES/4,5,3,304,305,306,307,308,309,310,311,312,
	1	313,5314,5319,324,325,883,884,120,120,0,0,0,0/
	DATA ANSWER/0,6,1,6,2,5,3,5,4,3,4,6,4,6,4,5,
	1	5,5,5,4,5,6,6,10,7,4,7,6/
	DATA ANSSTR/'T','E','M','P','L','E',
	1	'F','O','R','E','S','T',
	2	'3','0','0','0','3',
	3	'F','L','A','S','K',
	4	'R','U','B',
	5	'F','O','N','D','L','E',
	6	'C','A','R','R','E','S',
	7	'T','O','U','C','H',
	8	'B','O','N','E','S',
	9	'B','O','D','Y',
	1	'S','K','E','L','E','T',
	2	'R','U','S','T','Y','K','N','I','F','E',
	3	'N','O','N','E',
	4	'N','O','W','H','E','R',0/
C SVERBS, PAGE 2
C
	SVERBS=.TRUE.				!ASSUME WINS.
	IF(PRSO.NE.0) ODO2=ODESC2(PRSO)		!SET UP DESCRIPTORS.
	IF(PRSI.NE.0) ODI2=ODESC2(PRSI)
C
	IF(RI.EQ.0) CALL BUG(7,RI)		!ZERO IS VERBOTEN.
	IF(RI.LE.MXNOP) RETURN			!NOP?
	IF(RI.LE.MXJOKE) GO TO 100		!JOKE?
	GO TO (65000,66000,67000,68000,69000,
	1 1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,
	2 11000,12000,13000,14000,15000,16000,17000,18000,19000,20000,
	3 21000,22000,23000,24000,25000,26000,27000),
	8	(RI-MXJOKE)
	CALL BUG(7,RI)
C
C ALL VERB PROCESSORS RETURN HERE TO DECLARE FAILURE.
C
10	SVERBS=.FALSE.				!LOSE.
	RETURN
C
C JOKE PROCESSOR.
C FIND PROPER ENTRY IN JOKES, USE IT TO SELECT STRING TO PRINT.
C
100	I=JOKES(RI-MXNOP)			!GET TABLE ENTRY.
	J=I/1000				!ISOLATE # STRINGS.
	IF(J.NE.0) I=MOD(I,1000)+RND(J)		!IF RANDOM, CHOOSE.
	CALL RSPEAK(I)				!PRINT JOKE.
	RETURN
C SVERBS, PAGE 2A
C
C V65--	ROOM
C
65000	SVERBS=RMDESC(2)			!DESCRIBE ROOM ONLY.
	RETURN
C
C V66--	OBJECTS
C
66000	SVERBS=RMDESC(1)			!DESCRIBE OBJ ONLY.
	IF(.NOT.TELFLG) CALL RSPEAK(138)	!NO OBJECTS.
	RETURN
C
C V67--	RNAME
C
67000	CALL RSPEAK(RDESC2-HERE)		!SHORT ROOM NAME.
	RETURN
C
C V68--	RESERVED
C
68000	RETURN
C
C V69--	RESERVED
C
69000	RETURN
C SVERBS, PAGE 3
C
C V70--	BRIEF.  SET FLAG.
C
1000	BRIEFF=.TRUE.				!BRIEF DESCRIPTIONS.
	SUPERF=.FALSE.
	CALL RSPEAK(326)
	RETURN
C
C V71--	VERBOSE.  CLEAR FLAGS.
C
2000	BRIEFF=.FALSE.				!LONG DESCRIPTIONS.
	SUPERF=.FALSE.
	CALL RSPEAK(327)
	RETURN
C
C V72--	SUPERBRIEF.  SET FLAG.
C
3000	SUPERF=.TRUE.
	CALL RSPEAK(328)
	RETURN
C
C V73-- STAY (USED IN ENDGAME).
C
4000	IF(WINNER.NE.AMASTR) GO TO 4100		!TELL MASTER, STAY.
	CALL RSPEAK(781)			!HE DOES.
	CTICK(CEVFOL)=0				!NOT FOLLOWING.
	RETURN
C
4100	IF(WINNER.EQ.PLAYER) CALL RSPEAK(664)	!JOKE.
	RETURN
C
C V74--	VERSION.  PRINT INFO.
C
5000	WRITE(OUTCH,5010) VMAJ,VMIN,VEDIT
5010	FORMAT(' V',I1,'.',I2,A1)
	TELFLG=.TRUE.
	RETURN
C
C V75--	SWIM.  ALWAYS A JOKE.
C
6000	I=330					!ASSUME WATER.
	IF((RFLAG(HERE).AND.(RWATER+RFILL)).EQ.0)
	1	I=331+RND(3)			!IF NO WATER, JOKE.
	CALL RSPEAK(I)
	RETURN
C
C V76--	GERONIMO.  IF IN BARREL, FATAL, ELSE JOKE.
C
7000	IF(HERE.EQ.MBARR) GO TO 7100		!IN BARREL?
	CALL RSPEAK(334)			!NO, JOKE.
	RETURN
C
7100	CALL JIGSUP(335)			!OVER FALLS.
	RETURN
C
C V77--	SINBAD ET AL.  CHASE CYCLOPS, ELSE JOKE.
C
8000	IF((HERE.EQ.MCYCL).AND.QHERE(CYCLO,HERE)) GO TO 8100
	CALL RSPEAK(336)			!NOT HERE, JOKE.
	RETURN
C
8100	CALL NEWSTA(CYCLO,337,0,0,0)		!CYCLOPS FLEES.
	CYCLOF=.TRUE.				!SET ALL FLAGS.
	MAGICF=.TRUE.
	OFLAG2(CYCLO)=OFLAG2(CYCLO).AND. .NOT.FITEBT
	RETURN
C
C V78--	WELL.  OPEN DOOR, ELSE JOKE.
C
9000	IF(RIDDLF.OR.(HERE.NE.RIDDL)) GO TO 9100 !IN RIDDLE ROOM?
	RIDDLF=.TRUE.				!YES, SOLVED IT.
	CALL RSPEAK(338)
	RETURN
C
9100	CALL RSPEAK(339)			!WELL, WHAT?
	RETURN
C
C V79--	PRAY.  IF IN TEMP2, POOF!
C
10000	IF(HERE.NE.TEMP2) GO TO 10050		!IN TEMPLE?
	IF(MOVETO(FORE1,WINNER)) GO TO 10100	!FORE1 STILL THERE?
10050	CALL RSPEAK(340)			!JOKE.
	RETURN
C
10100	F=RMDESC(3)				!MOVED, DESCRIBE.
	RETURN
C
C V80--	TREASURE.  IF IN TEMP1, POOF!
C
11000	IF(HERE.NE.TEMP1) GO TO 11050	!IN TEMPLE?
	IF(MOVETO(TREAS,WINNER)) GO TO 10100	!TREASURE ROOM THERE?
11050	CALL RSPEAK(341)			!NOTHING HAPPENS.
	RETURN
C
C V81--	TEMPLE.  IF IN TREAS, POOF!
C
12000	IF(HERE.NE.TREAS) GO TO 12050		!IN TREASURE?
	IF(MOVETO(TEMP1,WINNER)) GO TO 10100	!TEMP1 STILL THERE?
12050	CALL RSPEAK(341)			!NOTHING HAPPENS.
	RETURN
C
C V82--	BLAST.  USUALLY A JOKE.
C
13000	I=342					!DONT UNDERSTAND.
	IF(PRSO.EQ.SAFE) I=252			!JOKE FOR SAFE.
	CALL RSPEAK(I)
	RETURN
C
C V83--	SCORE.  PRINT SCORE.
C
14000	CALL SCORE(.FALSE.)
	RETURN
C
C V84--	QUIT.  FINISH OUT THE GAME.
C
15000	CALL SCORE(.TRUE.)			!TELLL SCORE.
	IF(.NOT.YESNO(343,0,0)) RETURN		!ASK FOR Y/N DECISION.
	CLOSE (UNIT=DBCH)			!CLEAN UP.
	CALL EXIT				!BYE.
C SVERBS, PAGE 4
C
C V85--	FOLLOW (USED IN ENDGAME)
C
16000	IF(WINNER.NE.AMASTR) RETURN		!TELL MASTER, FOLLOW.
	CALL RSPEAK(782)
	CTICK(CEVFOL)=-1			!STARTS FOLLOWING.
	RETURN
C
C V86--	WALK THROUGH
C
17000	IF((SCOLRM.EQ.0).OR.((PRSO.NE.SCOL).AND.
	1	((PRSO.NE.WNORT).OR.(HERE.NE.BKBOX)))) GO TO 17100
	SCOLAC=SCOLRM				!WALKED THRU SCOL.
	PRSO=0					!FAKE OUT FROMDR.
	CTICK(CEVSCL)=6				!START ALARM.
	CALL RSPEAK(668)			!DISORIENT HIM.
	F=MOVETO(SCOLRM,WINNER)			!INTO ROOM.
	F=RMDESC(3)				!DESCRIBE.
	RETURN
C
17100	IF(HERE.NE.SCOLAC) GO TO 17300		!ON OTHER SIDE OF SCOL?
	DO 17200 I=1,12,3			!WALK THRU PROPER WALL?
	  IF((SCOLWL(I).EQ.HERE).AND.(SCOLWL(I+1).EQ.PRSO))
	1	GO TO 17500			!IN SPECIFIED ROOM?
17200	CONTINUE
C
17300	IF((OFLAG1(PRSO).AND.TAKEBT).NE.0) GO TO 17400	!TKBLE?
	I=669					!NO, JOKE.
	IF(PRSO.EQ.SCOL) I=670			!SPECIAL JOKE FOR SCOL.
	CALL RSPSUB(I,ODO2)
	RETURN
C
17400	I=671					!JOKE.
	IF(OROOM(PRSO).NE.0) I=552+RND(5)	!SPECIAL JOKES IF CARRY.
	CALL RSPEAK(I)
	RETURN
C
17500	PRSO=SCOLWL(I+2)			!THRU SCOL WALL...
	DO 17600 I=1,8,2			!FIND MATCHING ROOM.
	  IF(PRSO.EQ.SCOLDR(I)) SCOLRM=SCOLDR(I+1)
17600	CONTINUE				!DECLARE NEW SCOLRM.
	CTICK(CEVSCL)=0				!CANCEL ALARM.
	CALL RSPEAK(668)			!DISORIENT HIM.
	F=MOVETO(BKBOX,WINNER)			!BACK IN BOX ROOM.
	F=RMDESC(3)
	RETURN
C
C V87--	RING.  A JOKE.
C
18000	I=359					!CANT RING.
	IF(PRSO.EQ.BELL) I=360			!DING, DONG.
	CALL RSPEAK(I)				!JOKE.
	RETURN
C
C V88--	BRUSH.  JOKE WITH OBSCURE TRAP.
C
19000	IF(PRSO.EQ.TEETH) GO TO 19100		!BRUSH TEETH?
	CALL RSPEAK(362)			!NO, JOKE.
	RETURN
C
19100	IF(PRSI.NE.0) GO TO 19200		!WITH SOMETHING?
	CALL RSPEAK(363)			!NO, JOKE.
	RETURN
C
19200	IF((PRSI.EQ.PUTTY).AND.(OADV(PUTTY).EQ.WINNER))
	1	GO TO 19300			!WITH PUTTY?
	CALL RSPSUB(364,ODI2)			!NO, JOKE.
	RETURN
C
19300	CALL JIGSUP(365)			!YES, DEAD!!!!!
	RETURN
C SVERBS, PAGE 5
C
C V89--	DIG.  UNLESS SHOVEL, A JOKE.
C
20000	IF(PRSO.EQ.SHOVE) RETURN		!SHOVEL?
	I=392					!ASSUME TOOL.
	IF((OFLAG1(PRSO).AND.TOOLBT).EQ.0) I=393
	CALL RSPSUB(I,ODO2)
	RETURN
C
C V90--	TIME.  PRINT OUT DURATION OF GAME.
C
21000	CALL GTTIME(K)			!GET PLAY TIME.
	I=K/60
	J=MOD(K,60)
	WRITE(OUTCH,21010)
	IF(I.NE.0) WRITE(OUTCH,21011) I
	IF(I.GE.2) WRITE(OUTCH,21012)
	IF(I.EQ.1) WRITE(OUTCH,21013)
	IF(J.EQ.1) WRITE(OUTCH,21014) J
	IF(J.NE.1) WRITE(OUTCH,21015) J
	TELFLG=.TRUE.
	RETURN
C
21010	FORMAT(' You have been playing Dungeon for ',$)
21011	FORMAT('+',I3,' hour',$)
21012	FORMAT('+s and ',$)
21013	FORMAT('+ and ',$)
21014	FORMAT('+',I2,' minute.')
21015	FORMAT('+',I2,' minutes.')
C
C V91--	LEAP.  USUALLY A JOKE, WITH A CATCH.
C
22000	IF(PRSO.EQ.0) GO TO 22200		!OVER SOMETHING?
	IF(QHERE(PRSO,HERE)) GO TO 22100	!HERE?
	CALL RSPEAK(447)			!NO, JOKE.
	RETURN
C
22100	IF((OFLAG2(PRSO).AND.VILLBT).EQ.0) GO TO 22300
	CALL RSPSUB(448,ODO2)			!CANT JUMP VILLAIN.
	RETURN
C
22200	IF(.NOT.FINDXT(XDOWN,HERE)) GO TO 22300	!DOWN EXIT?
	IF((XTYPE.EQ.XNO).OR.((XTYPE.EQ.XCOND).AND.
	1	.NOT.FLAGS(XFLAG))) GO TO 22400	!BLOCKED OFF?
22300	CALL RSPEAK(314+RND(5))			!WHEEEE!
	RETURN
C
22400	CALL JIGSUP(449+RND(4))			!FATAL LEAP.
	RETURN
C SVERBS, PAGE 6
C
C V92--	LOCK.
C
23000	IF((PRSO.EQ.GRATE).AND.(HERE.EQ.MGRAT))
	1	GO TO 23200
23100	CALL RSPEAK(464)			!NOT LOCK GRATE.
	RETURN
C
23200	GRUNLF=.FALSE.				!GRATE NOW LOCKED.
	CALL RSPEAK(214)
	TRAVEL(REXIT(HERE)+1)=214		!CHANGE EXIT STATUS.
	RETURN
C
C V93--	UNLOCK
C
24000	IF((PRSO.NE.GRATE).OR.(HERE.NE.MGRAT))
	1	GO TO 23100			!NOT UNLOCK GRATE.
	IF(PRSI.EQ.KEYS) GO TO 24200		!GOT KEYS?
	CALL RSPSUB(465,ODI2)			!NO, JOKE.
	RETURN
C
24200	GRUNLF=.TRUE.				!UNLOCK GRATE.
	CALL RSPEAK(217)
	TRAVEL(REXIT(HERE)+1)=217		!CHANGE EXIT STATUS.
	RETURN
C
C V94--	DIAGNOSE.
C
25000	I=FIGHTS(WINNER,.FALSE.)		!GET FIGHTS STRENGTH.
	J=ASTREN(WINNER)			!GET HEALTH.
	K=MIN0(I+J,4)				!GET STATE.
	IF(.NOT.CFLAG(CEVCUR)) J=0		!IF NO WOUNDS.
	L=MIN0(4,IABS(J))			!SCALE.
	CALL RSPEAK(473+L)			!DESCRIBE HEALTH.
	I=(30*(-J-1))+CTICK(CEVCUR)		!COMPUTE WAIT.
	IF(J.NE.0) WRITE(OUTCH,25100) I
25100	FORMAT(' You will be cured after ',I3,' moves.')
	CALL RSPEAK(478+K)			!HOW MUCH MORE?
	IF(DEATHS.NE.0) CALL RSPEAK(482+DEATHS)	!HOW MANY DEATHS?
	RETURN
C SVERBS, PAGE 7
C
C V95--	INCANT
C
26000	DO 26100 I=1,6				!SET UP PARSE.
	  P1(I)=' '
	  P2(I)=' '
26100	CONTINUE
	WP=1					!WORD POINTER.
	CP=1					!CHAR POINTER.
	IF(PRSCON.LE.1) GO TO 26300
	DO 26200 I=PRSCON,INLNT			!PARSE INPUT
	  IF(INBUF(I).EQ.',') GO TO 26300	!END OF PHRASE?
	  IF(INBUF(I).NE.' ') GO TO 26150	!SPACE?
	  IF(CP.NE.1) WP=WP+1
	  CP=1
	  GO TO 26200
26150	  IF(WP.EQ.1) P1(CP)=INBUF(I)		!STUFF INTO HOLDER.
	  IF(WP.EQ.2) P2(CP)=INBUF(I)
	  CP=MIN0(CP+1,6)
26200	CONTINUE
C
26300	PRSCON=1				!KILL REST OF LINE.
	IF(P1(1).NE.' ') GO TO 26400		!ANY INPUT?
	CALL RSPEAK(856)			!NO, HO HUM.
	RETURN
C
26400	CALL ENCRYP(P1,CH)			!COMPUTE RESPONSE.
	IF(P2(1).NE.' ') GO TO 26600	!TWO PHRASES?
C
	IF(SPELLF) GO TO 26550			!HE'S TRYING TO LEARN.
	IF((RFLAG(TSTRS).AND.RSEEN).EQ.0) GO TO 26575
	SPELLF=.TRUE.				!TELL HIM.
	TELFLG=.TRUE.
	WRITE(OUTCH,26510) P1,CH
26510	FORMAT(' A hollow voice replies:  "',6A1,1X,6A1,'".')
	RETURN
C
26550	CALL RSPEAK(857)			!HE'S GOT ONE ALREADY.
	RETURN
C
26575	CALL RSPEAK(858)			!HE'S NOT IN ENDGAME.
	RETURN
C
26600	IF((RFLAG(TSTRS).AND.RSEEN).NE.0) GO TO 26800
	DO 26700 I=1,6
	  IF(P2(I).NE.CH(I)) GO TO 26575	!WRONG.
26700	CONTINUE
	SPELLF=.TRUE.				!IT WORKS.
	CALL RSPEAK(859)
	CTICK(CEVSTE)=1				!FORCE START.
	RETURN
C
26800	CALL RSPEAK(855)			!TOO LATE.
	RETURN
C SVERBS, PAGE 8
C
C V96--	ANSWER
C
27000	IF((PRSCON.GT.1).AND.
	1	(HERE.EQ.FDOOR).AND.INQSTF)
	2	GO TO 27100
	CALL RSPEAK(799)			!NO ONE LISTENS.
	PRSCON=1
	RETURN
C
27100	K=1					!POINTER INTO ANSSTR.
	DO 27300 J=1,28,2			!CHECK ANSWERS.
	  NEWK=K+ANSWER(J+1)			!COMPUTE NEXT K.
	  IF(QUESNO.NE.ANSWER(J)) GO TO 27300	!ONLY CHECK PROPER ANS.
	  I=PRSCON-1				!SCAN ANSWER.
	  DO 27200 L=K,NEWK-1
27150	    I=I+1				!SKIP INPUT BLANKS.
	    IF(I.GT.INLNT) GO TO 27300		!END OF INPUT? LOSE.
	    IF(INBUF(I).EQ.' ') GO TO 27150
	    IF(INBUF(I).NE.ANSSTR(L)) GO TO 27300
27200	  CONTINUE
	  GO TO 27500				!RIGHT ANSWER.
27300	K=NEWK
C
	PRSCON=1				!KILL REST OF LINE.
	NQATT=NQATT+1				!WRONG, CRETIN.
	IF(NQATT.GE.5) GO TO 27400		!TOO MANY WRONG?
	CALL RSPEAK(800+NQATT)			!NO, TRY AGAIN.
	RETURN
C
27400	CALL RSPEAK(826)			!ALL OVER.
	CFLAG(CEVINQ)=.FALSE.			!LOSE.
	RETURN
C
27500	PRSCON=1				!KILL REST OF LINE.
	CORRCT=CORRCT+1				!GOT IT RIGHT.
	CALL RSPEAK(800)			!HOORAY.
	IF(CORRCT.GE.3) GO TO 27600		!WON TOTALLY?
	CTICK(CEVINQ)=2				!NO, START AGAIN.
	QUESNO=MOD(QUESNO+3,8)
	NQATT=0
	CALL RSPEAK(769)			!ASK NEXT QUESTION.
	CALL RSPEAK(770+QUESNO)
	RETURN
C
27600	CALL RSPEAK(827)			!QUIZ OVER,
	CFLAG(CEVINQ)=.FALSE.
	OFLAG2(QDOOR)=OFLAG2(QDOOR).OR.OPENBT	!OPEN DOOR.
	RETURN
C
	END