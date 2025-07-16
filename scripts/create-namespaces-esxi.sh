BLOCKS_PER_NS=3746979595
ADAPTER="vmhba0"

for i in {1..8}; do
    echo "Creating namespace $i"
    esxcli nvme device namespace create \
        --adapter $ADAPTER \
        --capacity $BLOCKS_PER_NS \
        --size $BLOCKS_PER_NS \
        --flbas 0 \
        --dps 0 \
        --nmic 0
    
    # Получите controller ID
    CONTROLLER_ID=$(esxcli nvme device controller list --adapter $ADAPTER | tail -n1 | awk '{print $1}')
    
    # Подключите namespace к контроллеру
    esxcli nvme device namespace attach --adapter $ADAPTER --namespace 2 --controller $CONTROLLER_ID
        
    echo "Namespace $i created and attached"
done
