########################################################
# Name: CopyFile2NetworkPC                              
# Author : Jeric Lambit    
# Date Created: 
# Version:
# Doc: 
# Version 
########################################################

# GitHub : https://github.com/jericjl
# Linkedin : https://www.linkedin.com/in/lambitjeric/

########################################################

#Subnet / Network
$subnet = "172.16.14"
    #Input the value where the IP address started from 1-254 
    $num = 1
    #set the loop value to maximum 254 starting from 0
    for($i = 0; $i -le 254; $i++){
        $network = Write-Output "$subnet.$num" #Display the ipaddress as string value
        $ip =  $network #Swap the value into another variable
        $val = ping $ip -n 1 | Select-String "Reply" #Ping the workstation IP address and detect result if returns "Reply" value
        if ($val -eq $null) 
            {
            
            #Run command / Function here if null value
                
            }
        else 
            {
            #Delete the Drive letter to make sure that is does not exist
             net use Y: /delete     
             
             #Map the Drive to the PC
             #change the windows user account and save location depending on your preference
             net use Y: \\$network\Users\admin-user\Desktop /user:$network\admin-user password_here   
             
             #Copy the file to specified location, modify depending on your preference
             Copy-Item 'C:\File.txt' -destination "\\$network\Users\admin-user\Desktop" -recurse

             #Delete the Drive from mapping         
             net use Y: /delete             
           }
           #This is where the value autoincrement depends on the number of maximum value in the for loop
           $num++

 
    }


