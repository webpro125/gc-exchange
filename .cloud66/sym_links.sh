#mkdir -p $STACK_BASE/shared/config
#chown nginx:app_writers $STACK_BASE/shared/config
#rm -rf $STACK_PATH/uploads
ln -nsf $STACK_BASE/shared/config/gces-staging.p12 $STACK_PATH/config/gces-staging.p12
