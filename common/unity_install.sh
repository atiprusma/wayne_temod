# Reading thermal map
TMS=/vendor/etc/thermal-engine-map.conf
TMC=$TMPDIR/system/vendor/etc/thermal-engine-map.conf

kuy() {
  TLIST=$(cat $1 | cut -d\: -f2 | cut -d\] -f1)
  cp_ch $1 $TMPDIR/system$TMS
  for T in $TLIST;
  do
     cp_ch $2 $TMPDIR/system/vendor/etc/$T
  done
}

if [ "$TMS" ];
then
    ui_print " "
    ui_print "- System $(basename $TMS) found, Do you want to use it?"
    ui_print "  Vol+ (Up)   = Yes"
    ui_print "  Vol- (Down) = Custom by Givairuz"
    if $VKSEL;
    then
        ui_print " "
        ui_print "  Using system map"
        kuy $TMS $TMPDIR/temod
        U="UnF"
    else
        ui_print " "
        ui_print "  Using custom map by Givairuz"
        cp_ch -r $TMPDIR/custom/. $TMPDIR/system/vendor/etc
        U="UnF x GK"
    fi
    ui_print " "
    ui_print "- Use custom thermal bin?"
    ui_print "  Vol+ (Up)   = Yes, Use LOS (better throttling)"
    ui_print "  Vol- (Down) = No, Use from system"
    if $VKSEL;
    then
        ui_print " "
        ui_print "  Using LOS thermal bin"
        cp_ch $TMPDIR/los-bin $TMPDIR/system/vendor/bin/thermal-engine 0755
        N="$U x LOS"
    else
        N="$U"
        ui_print " "
        ui_print "  Using system thermal bin"
    fi
    ui_print " "
    ui_print "$(ls $TMPDIR/system/vendor/etc/)"
else    
    ui_print "- $TM not found, using one conf"
    cp_ch $TMPDIR/common/temod $TMPDIR/system/vendor/etc/thermal-engine.conf 
fi
if [ ! "$U" == "UnF" -o "$N" ];
then
    sed -i "2 s/UnF/$N/" $TMPDIR/module.prop
fi
# Report
[ ! -f $TMC ] && abort "  ! $(basename $TMS) not installed"
