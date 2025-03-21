###############################################################
#  Generated by:      Cadence Innovus 21.35-s114_1
#  OS:                Linux x86_64(Host ID allman)
#  Generated on:      Mon Mar  3 17:28:11 2025
#  Design:            Col_encoder_3B
#  Command:           write_floorplan Col_encoder_3B.fp
###############################################################

Version: 8

Head Box: 0.0000 0.0000 370.4400 40.2600
IO Box: 0.0000 0.0000 370.4400 40.2600
Core Box: 10.0800 0.0000 360.3600 40.2600
UseStdUtil: false

######################################################
#  DesignRoutingHalo: <space> <bottomLayerName> <topLayerName>
######################################################

######################################################
#  Core Rows Parameters:                             #
######################################################
Row Spacing = 0.000000
Row SpacingType = 2
Row Flip = 2
Core Row Site: core_hd 

##############################################################################
#  DefRow: <name> <site> <x> <y> <orient> <num_x> <num_y> <step_x> <step_y>  #
##############################################################################
DefRow: ROW_0 core_hd 10.0800 0.0000 FS 625 1 0.5600 0.0000
DefRow: ROW_1 core_hd 10.0800 4.4800 N 625 1 0.5600 0.0000
DefRow: ROW_2 core_hd 10.0800 8.9600 FS 625 1 0.5600 0.0000
DefRow: ROW_3 core_hd 10.0800 13.4400 N 625 1 0.5600 0.0000
DefRow: ROW_4 core_hd 10.0800 17.9200 FS 625 1 0.5600 0.0000
DefRow: ROW_5 core_hd 10.0800 22.4000 N 625 1 0.5600 0.0000
DefRow: ROW_6 core_hd 10.0800 26.8800 FS 625 1 0.5600 0.0000
DefRow: ROW_7 core_hd 10.0800 31.3600 N 625 1 0.5600 0.0000

#######################################################################################################
#  Track: dir start number space layer_num layer1 [firstColor] [isSameColor] [width] [rule] [isRectOnly]#
#######################################################################################################
Track: Y 0.6100 65 0.6100 1 4
Track: X 1.5750 293 1.2600 1 4
Track: X 0.3150 588 0.6300 1 3
Track: Y 0.6100 65 0.6100 1 3
Track: Y 0.6100 65 0.6100 1 2
Track: X 0.3150 588 0.6300 1 2
Track: X 0.3150 588 0.6300 1 1
Track: Y 0.6100 65 0.6100 1 1

######################################################
#  GCellGrid: dir start number space                 #
######################################################
GCellGrid: X 365.7150 2 4.7250
GCellGrid: X 0.3150 59 6.3000
GCellGrid: X 0.0000 2 0.3150
GCellGrid: Y 37.2100 2 3.0500
GCellGrid: Y 0.6100 7 6.1000
GCellGrid: Y 0.0000 2 0.6100

###############################1p########################
#  <SelectiveBlockage>                                #
#     <cell name="cell_name" />                     #
#  </SelectiveBlockage                                #
#######################################################

######################################################
#  ScanGroup: groupName startPin stopPin             #
######################################################

######################################################
#  JtagCell:  leafCellName                           #
#  JtagInst:  <instName | HInstName>                 #
######################################################

#########################################################
#  PhysicalNet: <name> [-pwr|-gnd|-tiehi|-tielo]        #
#########################################################
PhysicalNet: VDD -pwr
PhysicalNet: VSS -gnd

#####################################################################################
# <PGNets>                                                                          #
#    <PGNet name="net_name">                                                        #
#       <HNet name="hnet_name">                                                     #
#          <Port hinst="hinst_name" name="port_name" direction="in|out|inout" />    #
#       </HNet>                                                                     #
#    </PGNet>                                                                       #
# </PGNets>                                                                         #
#####################################################################################

#########################################################
#  PhysicalInstance: <name> <cell> <orient> <llx> <lly> #
#########################################################

######################################################
#  SpareCell: cellName                               #
#  SpareInst: instName                               #
######################################################

#####################################################################
#  Group: <group_name> <nrHinst> [-isPhyHier]                       #
#    <inst_name>                                                    #
#    ...                                                            #
#####################################################################

#####################################################################
#  Fence:  <name> <llx> <lly> <urx> <ury> <nrConstraintBox>         #
#    ConstraintBox: <llx> <lly> <urx> <ury>                         #
#    ...                                                            #
#  Region: <name> <llx> <lly> <urx> <ury> <nrConstraintBox>         #
#    ConstraintBox: <llx> <lly> <urx> <ury>                         #
#    ...                                                            #
#  Guide:  <name> <llx> <lly> <urx> <ury> <nrConstraintBox>         #
#    ConstraintBox: <llx> <lly> <urx> <ury>                         #
#    ...                                                            #
#  SoftGuide: <name>                                                #
#    ...                                                            #
#####################################################################

###########################################################################
#  <Constraints>                                                          #
#     <Constraint  type="fence|guide|region|softguide"                    #
#                  readonly=1  name="blk_name">                           #
#       <Box llx=1 lly=2 urx=3 ury=4 /> ...                               #
#     </Constraint>                                                       #
#  </Constraints>                                                         #
###########################################################################

###########################################################################
#  <macro_place_constraint>                                               #
#          ...                                                            #
#  </macro_place_constraint>                                              #
###########################################################################

######################################################################################
#  BlackBox: -cell <cell_name> { -size <x> <y> |  -area <um^2> | \                  #
#            -gatecount <count> <areapergate> <utilization> | \                     #
#            {-gateArea <gateAreaValue> [-macroArea <macroAreaValue>]} } \          #
#            [-minwidth <w> | -minheight <h> | -fixedwidh <w> | -fixedheight <h>] \ #
#            [-aspectratio <ratio>]                                                  #
#            [-boxList <nrConstraintBox>                                             #
#              ConstraintBox: <llx> <lly> <urx> <ury>                                #
#              ... ]                                                                 #
######################################################################################

#######################################################################################
#  <Blackboxes>                                                                       #
#     <Blackbox  cell=name  width=N height=N                                          #
#                { area=A | gatecount=N areaPerGate=A cellUtil=F |                    #
#                  gateArea=F {macroArea=F | macorList='str'} includeMacroArea={0|1}} #
#                [minWidth=N | minHeight=N | fixedWidh=N | fixedHeight=N]             #
#                [aspectRatio=R] >                                                    #
#         <Box llx=float lly=float urx=float ury=float /> ...                         #
#     </Blackbox>                                                                     #
#  </Blackboxes>                                                                      #
#######################################################################################

######################################################
#  Instance: <name> <orient> <llx> <lly>             #
######################################################

#################################################################
#  Block: <name> <orient> [<llx> <lly>]                         #
#         [<haloLeftMargin>  <haloBottomMargin>                 #
#          <haloRightMargin> <haloTopMargin> <haloFromInstBox>] #
#         [<IsInstDefCovered> <IsInstPreplaced>]                #
#                                                               #
#  Block with INT_MAX loc is for recording the halo block with  #
#  non-prePlaced status                                         #
#################################################################

###########################################################################
#  BlockRoutingHalo: <name> <space> <bottomLayer> <topLayer> <-lithoHalo> #
###########################################################################

######################################################
#  BlockLayerObstruct: <name> <layerX> ...           #
######################################################

######################################################
#  FeedthroughBuffer: <instName>                     #
######################################################

###########################################################################
#  <HierarchicalPartitions>                                               #
#     <GlobalPinConstraints>                                              #
#         <PinSpacing spacing=val />                                      #
#         <PinSpacing layer=layerId spacing=val />                        #
#         <PinWidth layer=layerId width=val />                            #
#         <PinDepth layer=layerId depth=val />                            #
#         <CornerToPinDistance distance=val />                            #
#     </GlobalPinConstraints>                                             #
#     <CellPtnCut name="name" cuts=Num >                                  #
#        <Box llx=11.0 lly=22.0 urx=33.0 ury=44.0 /> ...                  #
#     </CellPtnCut>                                                       #
#     <NetGroup name="group_name" nets=val spacing=val isOptOrder=val   #
#         isAltLayer=val isPffGroup=val isSpreadPin=val                   #
#         isExcludeAllLayer=val isExcludeSameLayer=val keepOutDistance=val#
#         isPureExclude=val isCompactArea=val isMixedSignal=val >         #
#         <Net name="net_name" /> ...                                   #
#     </NetGroup>                                                         #
#     <Partition name="ptn_name"  hinst="name"                            #
#         coreToLeft=fval coreToRight=fval coreToTop=fval                 #
#         coreToBottom=val pinSpacingNorth=val pinSpacingWest=val         #
#         pinSpacingSouth=val pinSpacingEast=val  blockedLayers=xval >    #
#         <TrackHalfPitch Horizontal=val Vertical=val />                  #
#         <SpacingHalo left=10.0 right=11.0 top=11.0 bottom=11.0 />       #
#         <Clone hinst="hinst_name" orient=R0|R90|... />                  #
#         <PinLayer side="N|W|S|E" Metal1=yes Metal2=yes ... />           #
#         <RowSize cellHeight=1.0 railWidth=1.0 />                        #
#         <DefaultTechSite name="core" />                                   #
#         <RoutingHalo sideSize=11.0 bottomLayer=M1 topLayer=M2  />       #
#         <SpacingHalo left=11.0 right=11.0 top=11.0 bottom=11.0 />       #
#         <PinToCornerDistance  totalCorners=nrCorners >                  #
#            <Corner number=<cornerNumber> distance=<distance> /> ...     #
#         </PinToCornerDistance >                                         #
#         <PinSpacingArea llx=val lly=val urx=val ury=val spacing=val />  #
#         <LayerWidthDepth layer=layerId width=w depth=d spacing=val />   #
#         <PinConstraint>                                                 #
#            <Pin name="pinName" >                                      #
#               <edge2 edgeMap=val />                                    #
#               <spacing space=val />                                    #
#               <layer layerMap=xval />                                  #
#               <pinWidth width=val />                                   #
#               <pinDepth depth=val />                                   #
#               <location x=val y=val />                                 #
#            </Pin>                                                       #
#         </PinConstraint>                                                #
#     </Partition>                                                        #
#     <CellPinGroup name="group_name" cell="cell_name" pins=nr        #
#         spacing=val isOptOrder=val isAltLayer=val isSpreadPin=val       #
#         isExcludeAllLayer=val isExcludeSameLayer=val keepOutDistance=val#
#         isPureExclude=val isCompactArea=val >                           #
#         <GroupFTerm name="term_name" /> ...                             #
#     </CellPinGroup>                                                     #
#     <PartitionPinBlockage layerMap=x llx=1 lly=2 urx=3 ury=4 name="n" />#
#     <PinGuide name="name" boxes=num layerPriority=val cell="name" >     #
#        <Box llx=11.0 lly=22.0 urx=33.0 ury=44.0 layer=id /> ...         #
#     </PinGuide>                                                         #
#  </HierarchicalPartitions>                                              #
###########################################################################
<HierarchicalPartitions>
    <GlobalPinConstraints>
        <PinSpacing spacing=2 />
        <CornerToPinDistance distance=5 />
    </GlobalPinConstraints>
    <Partition name="Col_encoder_3B" hinst="" coreToLeft=0.0000 coreToRight=0.0000 coreToTop=0.0000 coreToBottom=0.0000 pinSpacingNorth=-1 pinSpacingWest=-1 pinSpacingSouth=-1 pinSpacingEast=-1 blockedLayers=0xf orient=R0>
	<PinLayer side="N" Metal2=yes Metal4=yes />
	<PinLayer side="W" Metal3=yes />
	<PinLayer side="S" Metal2=yes Metal4=yes />
	<PinLayer side="E" Metal3=yes />
    <PinToCornerDistance totalCorners=4 >
      <Corner number=0 distance=-1 />
      <Corner number=1 distance=-1 />
      <Corner number=2 distance=-1 />
      <Corner number=3 distance=-1 />
    </PinToCornerDistance>
    </Partition>
</HierarchicalPartitions>

####################################################################################
#  <PlacementBlockages>                                                            #
#     <Blockage name="blk_name" type="hard|soft|partial">                      #
#       <Attr density=1.2 excludeFlops=yes inst="inst_name" pushdown=yes />      #
#       <Box llx=1 lly=2 urx=3 ury=4 /> ...                                        #
#     </Blockage>                                                                  #
#  </PlacementBlockages>                                                           #
####################################################################################

#################################################################
#  <SizeBlockages>                                             #
#     <Blockage name="blk_name">                              #
#       <Box llx=1 lly=2 urx=3 ury=4 /> ...                     #
#     </Blockage>                                               #
#  </SizeBlockages>                                            #
#################################################################

##########################################################################################################################
#  <RouteBlockages>                                                                                                      #
#     <Blockage name="blk_name" type="User|RouteGuide|PtnCut|WideWire">                                              #
#       <Attr spacing=1.2 drw=1.2 inst="name" pushdown=yes fills=yes exceptpgnet=yes pgnetonly=yes coreeolblkg=yes />  #
#       <Layer type="route|cut|masterslice" id=layerNo />                                                              #
#       <Box llx=1 lly=2 urx=3 ury=4 /> ...                                                                              #
#       <Poly points=nr x0=1 y0=1 x1=2 y2=2 ...  />                                                                      #
#     </Blockage>                                                                                                        #
#  </RouteBlockages>                                                                                                     #
##########################################################################################################################

######################################################
#  NetWeight: <net_name> <weight (in integer)>       #
######################################################

###########################################################################################
# NetbottomPreferredRoutingLayer:  <net_name> <bottomPreferredRoutingLayer (in integer)>  #
###########################################################################################

################################################################
# NetAvoidDetour:  <net_name>  < avoidDetour  { 1| 0}>   #
################################################################

#################################################################
#  SprFile: <file_name>                                         #
#################################################################
SprFile: Col_encoder_3B.fp.spr

###################################################################################################################
#  PGPin: <pin> <net> {in|out|inout} {pwr|gnd|-} {placed|fixed|-} <x> <y> <side> <layerId> <nrBox> <NETEXPR=""> #
#    PinBox: <llx> <lly> <urx> <ury>                                                                              #
#    PinPoly: <nrPts> <x1> <y1> <x2> <y2>...<xn> <yn>                                                             #
###################################################################################################################
PGPin: VDD VDD inout pwr fixed 2.5800 0.0000 S 4 1
  PinBox: 0.0800 0.0000 5.0800 5.0000 -lyr 4
PGPin: VDD VDD inout pwr fixed 2.5800 40.2600 N 4 1
  PinBox: 0.0800 35.2600 5.0800 40.2600 -lyr 4
PGPin: VDD VDD inout pwr fixed 181.4700 0.0000 S 4 1
  PinBox: 178.9700 0.0000 183.9700 5.0000 -lyr 4
PGPin: VDD VDD inout pwr fixed 181.4700 40.2600 N 4 1
  PinBox: 178.9700 35.2600 183.9700 40.2600 -lyr 4
PGPin: VDD VDD inout pwr fixed 360.3600 0.0000 S 4 1
  PinBox: 357.8600 0.0000 362.8600 5.0000 -lyr 4
PGPin: VDD VDD inout pwr fixed 360.3600 40.2600 N 4 1
  PinBox: 357.8600 35.2600 362.8600 40.2600 -lyr 4
PGPin: VSS VSS inout gnd fixed 10.0800 0.0000 S 4 1
  PinBox: 7.5800 0.0000 12.5800 5.0000 -lyr 4
PGPin: VSS VSS inout gnd fixed 10.0800 40.2600 N 4 1
  PinBox: 7.5800 35.2600 12.5800 40.2600 -lyr 4
PGPin: VSS VSS inout gnd fixed 188.9700 0.0000 S 4 1
  PinBox: 186.4700 0.0000 191.4700 5.0000 -lyr 4
PGPin: VSS VSS inout gnd fixed 188.9700 40.2600 N 4 1
  PinBox: 186.4700 35.2600 191.4700 40.2600 -lyr 4
PGPin: VSS VSS inout gnd fixed 367.8600 0.0000 S 4 1
  PinBox: 365.3600 0.0000 370.3600 5.0000 -lyr 4
PGPin: VSS VSS inout gnd fixed 367.8600 40.2600 N 4 1
  PinBox: 365.3600 35.2600 370.3600 40.2600 -lyr 4

##############################################################################
#  <IOPins>                                                                  #
#    <Pin name="pin_name" type="clock|power|ground|analog"                   #
#         status="covered|fixed|placed" is_special=1 >                       #
#      <Port>                                                                #
#        <Pref x=1 y=2 side="N|S|W|E|U|D" width=w depth=d orientation=val /> #
#        <Via name="via_name" x=1 y=2 BotMask=2 CutMask=1 TopMask=2 />...  #
#        <Layer id=id spacing=1.2 drw=1.2>                                   #
#          <Box llx=1 lly=2 urx=3 ury=4 /> ...                               #
#          <Poly points=nr x0=1 y0=1 x1=2 y2=2 ...           />              #
#        </Layer> ...                                                        #
#      </Port>  ...                                                          #
#      <NETEXPR>                                                             #
#        ground VSS                                                          #
#      </NETEXPR> ...                                                        #
#      <Antenna model=num type="name" value=float_num layer=num /> ...       #
#    </Pin> ...                                                              #
#  </IOPins>                                                                 #
##############################################################################

<IOPins>
  <Pin name="clk" status="placed" >
    <Port>
      <Pref x=235.9350 y=0.0000 side=S width=0.2800 depth=0.7250 />
      <Layer id=2 >
        <Box llx=235.7950 lly=0.0000 urx=236.0750 ury=0.7250 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="rst_n" status="placed" >
    <Port>
      <Pref x=185.5350 y=0.0000 side=S width=0.2800 depth=0.7250 />
      <Layer id=2 >
        <Box llx=185.3950 lly=0.0000 urx=185.6750 ury=0.7250 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="pixel_in[2]" status="placed" >
    <Port>
      <Pref x=0.0000 y=21.9600 side=W width=0.2800 depth=0.7250 orientation=R270 />
      <Layer id=3 >
        <Box llx=0.0000 lly=21.8200 urx=0.7250 ury=22.1000 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="pixel_in[1]" status="placed" >
    <Port>
      <Pref x=0.0000 y=16.4700 side=W width=0.2800 depth=0.7250 orientation=R270 />
      <Layer id=3 >
        <Box llx=0.0000 lly=16.3300 urx=0.7250 ury=16.6100 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="pixel_in[0]" status="placed" >
    <Port>
      <Pref x=0.0000 y=10.9800 side=W width=0.2800 depth=0.7250 orientation=R270 />
      <Layer id=3 >
        <Box llx=0.0000 lly=10.8400 urx=0.7250 ury=11.1200 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="data_valid" status="placed" >
    <Port>
      <Pref x=135.1350 y=0.0000 side=S width=0.2800 depth=0.7250 />
      <Layer id=2 >
        <Box llx=134.9950 lly=0.0000 urx=135.2750 ury=0.7250 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[15]" status="placed" >
    <Port>
      <Pref x=370.4400 y=1.2200 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=1.0800 urx=370.4400 ury=1.3600 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[14]" status="placed" >
    <Port>
      <Pref x=370.4400 y=3.6600 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=3.5200 urx=370.4400 ury=3.8000 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[13]" status="placed" >
    <Port>
      <Pref x=370.4400 y=6.1000 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=5.9600 urx=370.4400 ury=6.2400 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[12]" status="placed" >
    <Port>
      <Pref x=370.4400 y=8.5400 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=8.4000 urx=370.4400 ury=8.6800 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[11]" status="placed" >
    <Port>
      <Pref x=370.4400 y=11.5900 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=11.4500 urx=370.4400 ury=11.7300 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[10]" status="placed" >
    <Port>
      <Pref x=370.4400 y=14.0300 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=13.8900 urx=370.4400 ury=14.1700 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[9]" status="placed" >
    <Port>
      <Pref x=370.4400 y=16.4700 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=16.3300 urx=370.4400 ury=16.6100 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[8]" status="placed" >
    <Port>
      <Pref x=370.4400 y=18.9100 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=18.7700 urx=370.4400 ury=19.0500 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[7]" status="placed" >
    <Port>
      <Pref x=370.4400 y=21.9600 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=21.8200 urx=370.4400 ury=22.1000 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[6]" status="placed" >
    <Port>
      <Pref x=370.4400 y=24.4000 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=24.2600 urx=370.4400 ury=24.5400 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[5]" status="placed" >
    <Port>
      <Pref x=370.4400 y=26.8400 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=26.7000 urx=370.4400 ury=26.9800 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[4]" status="placed" >
    <Port>
      <Pref x=370.4400 y=29.2800 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=29.1400 urx=370.4400 ury=29.4200 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[3]" status="placed" >
    <Port>
      <Pref x=370.4400 y=32.3300 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=32.1900 urx=370.4400 ury=32.4700 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[2]" status="placed" >
    <Port>
      <Pref x=370.4400 y=34.7700 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=34.6300 urx=370.4400 ury=34.9100 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[1]" status="placed" >
    <Port>
      <Pref x=370.4400 y=37.2100 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=37.0700 urx=370.4400 ury=37.3500 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="encoded_dat[0]" status="placed" >
    <Port>
      <Pref x=370.4400 y=39.6500 side=E width=0.2800 depth=0.7250 orientation=R90 />
      <Layer id=3 >
        <Box llx=369.7150 lly=39.5100 urx=370.4400 ury=39.7900 />
      </Layer>
    </Port>
  </Pin>
  <Pin name="data_ready" status="placed" >
    <Port>
      <Pref x=0.0000 y=27.4500 side=W width=0.2800 depth=0.7250 orientation=R270 />
      <Layer id=3 >
        <Box llx=0.0000 lly=27.3100 urx=0.7250 ury=27.5900 />
      </Layer>
    </Port>
  </Pin>
</IOPins>

#####################################################################
#  <Property>                                                       #
#     <obj_type name="inst_name" >                                  #
#       <prop name="name" type=type_name value=val />               #
#       <Attr name="name" type=type_name value=val />               #
#     </obj_type>                                                   #
#  </Property>                                                      #
#  where:                                                           #
#       type is data type: Box, String, Int, PTR, Loc, double, Bits #
#       obj_type are: inst, Design, instTerm, Bump, cell, net       #
#####################################################################
<Properties>
  <Design name="Col_encoder_3B">
	<prop name="flow_timed_design_state" type=String value="preCts" def=yes />
	<prop name="flow_implementation_stage" type=String value="place_opt" def=yes />
  </Design>
</Properties>

###########################################################$############################################################################################
#  GlobalNetConnection: <net_name> {-pin|-instanceBasename|-net} <base_name_pattern> -type {pgpin|net|tiehi|tielo} {-all|-module <name>|-region <box>} [-override] #
########################################################################################################################################################
GlobalNetConnection: VDD -pin vdd -instanceBasename * -type pgpin -all
GlobalNetConnection: VSS -pin gnd -instanceBasename * -type pgpin -all

################################################################################
#  NetProperties: <net_name> [-special] [-def_prop {int|dbl|str} <value>]...   #
################################################################################

##################################################################################
#    Feedthru info:                                                              #
# <Feedthrus>                                                                    #
#   <Feedthru>                                                                   #
#       <tsv llx=n lly=n urx=n ury=n />                                          #
#       <stackvia layer=z llx=n lly=n urx=n ury=n />                             #
#       <bump front=name back=name  />                                           #
#   </Feedthru>                                                                  #
#   <Feedthru>                                                                   #
#   <...>                                                                        #
#   </Feedthru>                                                                  #
# </Feedthrus>                                                                   #
################################################################################
