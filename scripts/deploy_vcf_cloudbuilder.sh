#!/bin/bash
# Author: William Lam

OVFTOOL="/Applications/VMware OVF Tool/ovftool"
VCF_CLOUDBUILDER_OVA="/Volumes/Storage/Software/VMware-Cloud-Builder-5.2.1.0-24307856_OVF10.ova"

ESXI_HOST="mgmt-esx01.vcf.lab"
ESXI_USERNAME="root"
ESXI_PASSWORD="VMware1!"
VM_NETWORK="VM Network"
VM_DATASTORE="local-vmfs-datastore"

VCF_CLOUDBUILDER_VMNAME=cb.vcf.lab
VCF_CLOUDBUILDER_HOSTNAME=cb.vcf.lab
VCF_CLOUDBUILDER_IP=172.30.0.4
VCF_CLOUDBUILDER_SUBNET=255.255.255.0
VCF_CLOUDBUILDER_GATEWAY=172.30.0.1
VCF_CLOUDBUILDER_DNS_SERVER=172.30.0.2
VCF_CLOUDBUILDER_DNS_DOMAIN=vcf.lab
VCF_CLOUDBUILDER_DNS_SEARCH=vcf.lab
VCF_CLOUDBUILDER_NTP=104.167.215.195
VCF_CLOUDBUILDER_ROOT_PASSWORD="VMware1!VMware1!"
VCF_CLOUDBUILDER_ADMIN_USERNAME="admin"
VCF_CLOUDBUILDER_ADMIN_PASSWORD="VMware1!VMware1!"

### DO NOT EDIT BEYOND HERE ###

echo -e "\nDeploying VCF Installer ${VCF_CLOUDBUILDER_VMNAME} ..."
"${OVFTOOL}" --acceptAllEulas --noSSLVerify --skipManifestCheck --X:injectOvfEnv --allowExtraConfig --X:waitForIp --sourceType=OVA --powerOn \
"--net:Network 1=${VM_NETWORK}" --datastore=${VM_DATASTORE} --diskMode=thin --name=${VCF_CLOUDBUILDER_VMNAME} \
"--prop:guestinfo.hostname=${VCF_CLOUDBUILDER_HOSTNAME}" \
"--prop:guestinfo.ip0=${VCF_CLOUDBUILDER_IP}" \
"--prop:guestinfo.netmask0=${VCF_CLOUDBUILDER_SUBNET}" \
"--prop:guestinfo.gateway=${VCF_CLOUDBUILDER_GATEWAY}" \
"--prop:guestinfo.domain=${VCF_CLOUDBUILDER_DNS_DOMAIN}" \
"--prop:guestinfo.searchpath=${VCF_CLOUDBUILDER_DNS_SEARCH}" \
"--prop:guestinfo.DNS=${VCF_CLOUDBUILDER_DNS_SERVER}" \
"--prop:guestinfo.ROOT_PASSWORD=${VCF_CLOUDBUILDER_ROOT_PASSWORD}" \
"--prop:guestinfo.ADMIN_USERNAME=${VCF_CLOUDBUILDER_ADMIN_USERNAME}" \
"--prop:guestinfo.ADMIN_PASSWORD=${VCF_CLOUDBUILDER_ADMIN_PASSWORD}" \
"--prop:guestinfo.ntp=${VCF_CLOUDBUILDER_NTP}" \
${VCF_CLOUDBUILDER_OVA} "vi://${ESXI_USERNAME}:${ESXI_PASSWORD}@${ESXI_HOST}/"
