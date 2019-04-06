if [ -z $UF ]; then
  UF=$TMPDIR/common/unityfiles
  unzip -oq "$ZIPFILE" 'common/unityfiles/util_functions.sh' -d $TMPDIR >&2
  [ -f "$UF/util_functions.sh" ] || { ui_print "! Unable to extract zip file !"; exit 1; }
  . $UF/util_functions.sh
fi

comp_check
#MINAPI=21
#MAXAPI=25
#DYNLIB=true
#SYSOVER=true
DEBUG=true
#SKIPMOUNT=true

REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

REPLACE="
"
print_modname() {
  center_and_print
  unity_main
}

set_permissions() {
 : #oof
}

unity_custom() {
  # Check device
  product=$(grep_prop ro.build.product)
  model=$(grep_prop ro.product.model)
  if [ "$model" == "jasmine*" -o "wayne" -o "whyred" ]; then
      ui_print " "
      ui_print "- Your $model is supported"
      sed -i "s/meme/$model/g" $TMPDIR/module.prop
  else
      abort  "! Your $model isn't supported"
  fi
}
