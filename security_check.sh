#!/bin/bash
#Version 0.7.7
#Oleksii Muzychenko and Andrew Prokofiev

user="$1"

if [ ! -d "/home/$user/public_html" ]
        then
                echo -e '\033[36m'
                echo 'No such user or public_html folder here!'
                echo -e '\033[0m'
        else
                cd /home/$user/public_html
		
		echo -e "\e[1mNon-secure files permissions: \e[0m"
                echo -e '\033[32m'
		find -type f -perm 755
                find -type f -perm 777
		echo -e '\033[0m'		

		echo -e "\e[1mNon-secure folders permissions: \e[0m"	
		echo -e '\033[32m'
		find -type d -perm 777
                echo -e '\033[0m'

                echo -e "\e[1m.htaccess files with allow directive: \e[0m"
		echo -e '\033[35m'
                find -iwholename "*/.htaccess" -exec grep -H "allow from" {} \;
                echo -e '\033[0m'

                cd /home/$1/public_html

	if [[ -n $(find . -type f -iwholename "*/modules/system/system.info") ]]
        	then
			
					drupal7="$(curl -i -L --insecure --silent 'https://www.drupal.org/project/drupal'|egrep -o -i 'Drupal core [0-9\.]+'|awk '(NR == 2)'|cut -d' ' -f3)"
					echo -n "Current Old Drupal version are 5.23, 6.38 and: "
               			 	echo "${drupal7}"
		                	for i in 226 227 228 229 230 231; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
		                	find -type f -iwholename "*/modules/system/system.info" -exec grep -H "version = \"" {} \;|grep -v "7.69"|grep -v "5.23" |grep -v "6.38"
		                	for i in 226 227 228 229 230 231; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
	fi

        if [[ -n $(find -type f -iwholename "*/core/lib/Drupal.php") ]]
                then

                                        drupal8="$(curl -i -L --insecure --silent 'https://www.drupal.org/project/drupal'|egrep -o -i 'Drupal core [0-9\.]+'|awk '(NR == 1)'|cut -d' ' -f3)"
                                        echo -n "Current Drupal 8 version is: "
                                        echo "${drupal8}"
                                        for i in 196 160 124 88 52 16; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
                                        find -type f -iwholename "*/core/lib/Drupal.php" -exec grep -H "const VERSION =" {} \;|grep -v "8.8.1"
                                        for i in 196 160 124 88 52 16; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
        fi

	if [[ -n $(find . -type f -iwholename "*/administrator/manifests/files/joomla.xml") ]]
        	then
					joomla="$(curl -i -L --insecure --silent 'https://downloads.joomla.org/'|egrep -o -i 'Download Joomla! [0-9\.]+'|cut -d' ' -f3)"
					echo -n "Current Joomla version is: "
					echo "${joomla}"
		                	for i in 21 20 19 18 17 16; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
		                	find -iwholename "*/administrator/manifests/files/joomla.xml" -exec grep -H 'version>.\..\..<\/' {} \;|grep -v "3.9.14"
		                	for i in 21 20 19 18 17 16; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
	fi

	if [[ -n $(find . -type f -iwholename "*/wp-includes/version.php") ]]
		then
					wordpress="$(curl -i -L --insecure --silent 'https://wordpress.org/download'|egrep -o -i 'download wordpress [0-9\.]+'|cut -d' ' -f3)"
					echo -n "Current WordPress version is: "
					echo "${wordpress}"
		                	for i in 52 53 54 55 56 57; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo
		                	find . -type f -iwholename "*/wp-includes/version.php" -exec grep -H "\$wp_version =" {} \;|grep -v "5.3.2"
		                	for i in 52 53 54 55 56 57; do echo -en "\e[38;5;${i}m=================\e[0m"; done; echo

                        echo -e '\033[1m'		
			echo -n "Known vulerable plugins. Please check the IKB article and verify the versions:"
                        echo -e '\033[0m'
			echo -e "\033[94m"

#			Updates no available
			find /home/$user/public_html -iwholename "*/wp-content/plugins/duplicate-page"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/form-lightbox"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/rich-reviews"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/yuzo-related-post"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/slick-popup"

#			Updates available
			find /home/$user/public_html -iwholename "*/wp-content/themes/bridge"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/ad-inserter/ad-inserter.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/blog-designer/blog-designer.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/bold-page-builder/bold-builder.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/email-subscribers/email-subscribers.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/fb-messenger-live-chat/fb-messenger-live-chat.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/give/give.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/hybrid-composer/index.php"  -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-learning"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-booking"
			find /home/$user/public_html -iwholename "*/wp-content/plugins/nd-travel/nd-travel.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/simple-301-redirects-addon-bulk-uploader/simple-301-bulk-uploader.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/smart-google-code-inserter/smartgooglecode.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/syntaxhighlighter/syntaxhighlighter.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/wp-database-backup/wp-database-backup.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/wp-live-chat-support/wp-live-chat-support.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/yellow-pencil-visual-theme-customizer/yellow-pencil.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/eps-301-redirects/eps-301-redirects.php" -exec grep -H "Version: " {} \;
			find /home/$user/public_html -iwholename "*/wp-content/plugins/wp-maintenance/wp-maintenance.php" -exec grep -H "Version: " {} \;
			
			echo -e '\033[0m'
			echo -e '\033[1m'
                        echo -n "Nulled theme affected with wp_vcd malware. The whole theme should be removed :"
                        echo -e '\033[0m'
                        echo -e '\033[94m'
			find /home/$user/public_html -iwholename "*/wp-content/themes" -exec grep -Rl 'wp_vcd' {} \;
						
			echo -e "\033[0m"
	
	fi

#		Link checker 
		
		        echo -e '\033[1m'               
                        echo -n "Following links to the root found:"
                        echo -e '\033[0m'
                        echo -e "\033[94m"
			find /home/$user/public_html/ -type l | grep -e root -e passwd
			
			echo -e "\033[0m"

		
		echo -e "\e[1m Real owner: \e[0m"
                less /etc/trueuserowners |grep $user

		echo -e '\e[1m Domain: \e[0m'
                less /etc/trueuserdomains |grep $user

		echo -e '\e[1m Account status: \e[0m'
#		Account status
		if ls /var/cpanel/suspended/ |grep $user >/dev/null 2>&1
			then
				echo -e "$user - \e[1;38;5;9mSUSPENDED\e[0m"
			else
				domain=`grep " $user"$ /etc/trueuserdomains |cut -d ":" -f1`
				hname=`less /usr/local/apache/conf/httpd.conf |grep $domain -2 |grep -v 127.0.0.1 |grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' |sort|uniq`
				if /usr/local/bin/curl -s --resolve "$domain:80:$hname" http://$domain |egrep "403 Forbidden|403 Permission" >/dev/null 2>&1
					then
						echo -e "$user - \e[1;38;5;11mBLOCKED by .htaccess\e[0m"
						elif /usr/local/bin/curl -s --resolve "$domain:80:$hname" https://$domain |egrep "403 Forbidden|403 Permission" >/dev/null 2>&1
					then
						echo -e "$user - \e[1;38;5;11mBLOCKED by .htaccess\e[0m"
					else
						echo -e "$user - \e[1;38;5;10mONLINE\e[0m"
				fi
		fi
fi
