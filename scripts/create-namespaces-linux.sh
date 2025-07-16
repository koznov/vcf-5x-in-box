# Get Controller ID
CONTROLLER_ID=$(nvme id-ctrl /dev/nvme0 | grep ^cntlid | cut -d: -f2 | tr -d ' ')
echo "Controller ID: $CONTROLLER_ID"

# Size of each namespace - I have 15.36 TB drive which we are splitting into 8 devices with 512 bytes sectors
BLOCKS_PER_NS=3746979595

# Create 8 namespaces
for i in {1..8}; do
   echo "Creating namespace $i with size $BLOCKS_PER_NS blocks"
   
   # Create namespace
   nvme create-ns /dev/nvme0 --nsze=$BLOCKS_PER_NS --ncap=$BLOCKS_PER_NS --flbas=0 --dps=0
   
   # Check creation success
   if [ $? -eq 0 ]; then
       echo "Namespace $i created successfully"
       
       # Attach to controller
       nvme attach-ns /dev/nvme0 --namespace-id=$i --controllers=$CONTROLLER_ID
       
       if [ $? -eq 0 ]; then
           echo "Namespace $i attached to controller"
       else
           echo "Error attaching namespace $i"
       fi
   else
       echo "Error creating namespace $i"
       break
   fi
   
   echo "---"
done

# Check result
nvme list
