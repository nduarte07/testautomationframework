echo "======= START Smoke_Test Bundle  ======="
echo "Initial time:" 
date +%r

rspec --pattern ../test-scripts/01_homepage_general.rb --fail-fast=3 --format html > $WORKSPACE/html/SM_01_homepage_general.html
echo "01_homepage_general.rb finished"


echo "End time:" 
date +%r

echo "======= END Smoke Bundle  ======="
