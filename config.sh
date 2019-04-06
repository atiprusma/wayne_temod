print_modname() {
  ui_print " "
  ui_print "    *******************************************"
  ui_print "    *<name>*"
  ui_print "    *******************************************"
  ui_print "    *<version>*"
  ui_print "    *<author>*"
  ui_print "    *******************************************"
  ui_print " "
}

#MINAPI=21
#MAXAPI=25
#DYNAMICOREO=true
#SYSOVERRIDE=true
#DEBUG=true

unity_upgrade() {
  : # no ty
}

unity_custom() {
# Check device
product=$(grep_prop ro.build.product)
model=$(grep_prop ro.product.model)
if [ "$model" == "jasmine*" -o "wayne" -o "whyred" ]; then
    ui_print " "
    ui_print "- Your $model is supported"
    sed -i "s/meme/$model/g" $INSTALLER/module.prop
else
    ui_print " "
    ui_print "- Your $model isn't supported"
    exit 1
fi
}

REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

REPLACE="
"

set_permissions() {
  : # set_perm_recursive $UNITY$VEN/etc 0 0 0755 0644
  # set_perm_recursive $UNITY$VEN/bin 0 0 0755 0755
}
