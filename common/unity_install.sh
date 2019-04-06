# Downgrade version code; only testing purpose
sed -i "4 s/$(grep_prop versionCode $TMPDIR/module.prop)/1/" $TMPDIR/module.prop

# Reading thermal map
TMS=/vendor/etc/thermal-engine-map.conf
TMC=$TMPDIR/system/vendor/etc/thermal-engine-map.conf
BIN=/vendor/bin/thermal-engine

ui_print " "
ui_print "- Use custom thermal-engine-map?"
ui_print "  Vol+ (Up)   = Yes"
ui_print "  Vol- (Down) = No, use system default"
if $VKSEL;
then
    ui_print " "
    ui_print "  Using custom map"
    TMS=$TMPDIR/custom/custom-map
else
    ui_print " "
    ui_print "  Using system map"
fi

ui_print " "
ui_print "- Use custom thermal confs ?"
ui_print "  Vol+ (Up)   = Yes"
ui_print "  Vol- (Down) = No, Use system default"
if $VKSEL;
then
    ui_print " "
    ui_print "  Using custom confs"
    TC=$TMPDIR/custom/temod
else
    ui_print " "
    ui_print "  Using system confs"
    TC=/vendor/etc/thermal-engine-sgame.conf
fi 

ui_print " "
ui_print "- Use LOS thermal bin?"
ui_print "  Vol+ (Up)   = Yes (better throttling)"
ui_print "  Vol- (Down) = No Use from system"
if $VKSEL;
then
    ui_print " "
    ui_print "  Using LOS thermal bin"
    BIN=$TMPDIR/custom/los-bin
else
    ui_print " "
    ui_print "  Using system thermal bin"
    BIN=/vendor/bin/thermal-engine
fi

ui_print " "
if [ -f $TMS ]; then
    TLIST=$(cat $TMS | cut -d\: -f2 | cut -d\] -f1)
    cp_ch $TMS $TMC
    for T in $TLIST;
    do
        cp_ch $TC $(dirname $TMC)/$T
    done
else    
    ui_print "- thermal-engine-map not found, using one conf"
    cp_ch $TC $TMPDIR/system/vendor/etc/thermal-engine.conf
fi

[ -f $BIN ] || cp_ch $BIN $TMPDIR/system/vendor/bin/thermal-engine

