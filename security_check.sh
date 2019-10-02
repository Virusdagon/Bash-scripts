#!/bin/bash
#test version v 0.3
#Muzychenko Oleksii and Andrew Prokifiev

user="$1"

if [ ! -d "/home/$user/public_html" ]
        then
                echo -e '\033[36m'
                echo 'No such user here!'
                echo -e '\033[0m'
        else
                cd /home/$user/public_html

		echo -n "Non-secure files permissions : "
                echo -e '\033[32m'
		find -type f -perm 755
                find -type f -perm 777
		echo -e '\033[0m'		

		echo -n "Non-secure folders permissions : "	
		echo -e '\033[32m'
		find -type d -perm 777
                echo -e '\033[0m'

                echo -n ".htaccess files with allow directive : "
		echo -e '\033[35m'
                find -iwholename "*/.htaccess" -exec grep -H "allow from" {} \;
                echo -e '\033[0m'

                cd /home/$1/public_html
                echo -n "Current WordPress version is: "
                curl -i -L --insecure --silent 'https://wordpress.org/download'|egrep -o -i 'download wordpress [0-9\.]+'|cut -d' ' -f3
                echo -e '\033[31m=============================================================================================\033[0m'
                find . -type f -iwholename "*/wp-includes/version.php" -exec grep -H "\$wp_version =" {} \;
                echo -e '\033[31m=============================================================================================\033[0m'
                echo -n "Current Drupal version is: "
                curl -i -L --insecure --silent 'https://www.drupal.org/project/drupal'|egrep -o -i 'Drupal core [0-9\.]+'|awk '(NR == 2)'|cut -d' ' -f3
                echo -e '\033[33m=============================================================================================\033[0m'
                find -type f -iwholename "*/modules/system/system.info" -exec grep -H "version = \"" {} \;
                echo -e '\033[33m=============================================================================================\033[0m'
                echo -n "Current Joomla version is: "
                curl -i -L --insecure --silent 'https://downloads.joomla.org/'|egrep -o -i 'Download Joomla! [0-9\.]+'|cut -d' ' -f3
                echo -e '\033[34m=============================================================================================\033[0m'
                find -iwholename "*/administrator/manifests/files/joomla.xml" -exec grep -H 'version>.\..\..<\/' {} \;
                echo -e '\033[34m=============================================================================================\033[0m'

		echo -e '\033[0m'
		echo -n 'Known vulerable plugins. Please check the IKB article and verify the versions : '
		echo -e '\033[32m'
		find /home/$user/public_html -iwholename "*/wp-content/plugins/blog-designer/blog-designer.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/bold-page-builder/bold-builder.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/fb-messenger-live-chat/fb-messenger-live-chat.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/yuzo-related-post"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/yellow-pencil-visual-theme-customizer/yellow-pencil.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/wp-live-chat-support/wp-live-chat-support.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/form-lightbox"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-booking"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-learning"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-travel"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/smart-google-code-inserter/smartgooglecode.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/wp-database-backup/wp-database-backup.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/slick-popup"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/ad-inserter/ad-inserter.php" -exec grep -H "Version: " {} \;
		find /home/$user/public_html -iwholename "*/wp-content/plugins/simple-301-redirects-addon-bulk-uploader/simple-301-bulk-uploader.php" -exec grep -H "Version: " {} \;
 		find /home/$user/public_html -iwholename "*/wp-content/plugins/rich-reviews"
		find /home/$user/public_html -iwholename "*/wp-content/plugins/give/give.php" -exec grep -H "Version: " {} \;
			
		echo -e '\033[0m'


                less /etc/trueuserowners |grep $user

                less /etc/trueuserdomains |grep $user

                /scripts/accstatus $user

fi


#crontab -e -u $user
#exec bash -l

