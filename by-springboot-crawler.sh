#!/bin/bash

target="WebGoat-develop/"

echo $target

echo " "
echo "Collection Controllers..."
grep -Irw -e "@Controller" $target | cut -d ":" -f 1 | tee by-controllers.txt

echo " "
echo "Collection Services..."
grep -Irw -e "@Service" $target | cut -d ":" -f 1 | tee by-service.txt

echo " "
echo "Collecting Repositories..."
grep -Irw -e "@Repository" $target | cut -d ":" -f 1 | tee by-repository.txt

echo " "
echo "Collecting Spring Boot Application files..."
grep -Irw -e "@SpringBootApplication" $target | cut -d ":" -f 1 | tee by-spring-boot-app.txt

echo " "
echo "Collecting potential config files..."
find $target -name *.properties -o -name web.xml -o -name pom.xml -o -name spring.xml -o -name *.xml | tee by-configs.txt

echo " "
echo "Collecting URL Patterns..."
grep -Irn -e "@GetMapping" $target | tee by-get.txt

echo " "
echo "Collecting POST methods..."
grep -Irn -e "@PostMapping" $target | tee by-post.txt

echo " "
echo "Collecting PUT methods..."
grep -Irn -e "@PutMapping" $target | tee by-put.txt

echo " "
echo "Collecting GET methods..."
grep -Irn -e "@DeleteMapping" $target | tee by-delete.txt

echo " "
echo "Collecting RequestMapping..."
grep -Irn -e "@RequestMapping" $target | tee by-request-mapping.txt

echo " "
echo "Collecting WebSecurityConfigurerAdapters..."
grep -Irw -e "WebSecurityConfigurerAdapter" WebGoat-develop/ | grep -e "extends" | tee by-web-security-configurer-adpaters.txt

echo " "
echo "Collecting Serialzable implementation..."
grep -Irw -e "Serializable" WebGoat-develop | grep -I -e "implements" | tee by-serializable.txt

echo " "
echo "Collection Completed!"
echo "Calculating estimated statistics..."

echo " "
echo "Estimated Project Statistics:"
echo "# of controllers> " $(wc -l by-controllers.txt | cut -d " " -f 1)
echo "# of services> " $(wc -l by-service.txt | cut -d " " -f 1)
echo "# of repo> " $(wc -l by-repository.txt | cut -d " " -f 1)
echo "# of spring boot app> " $(wc -l by-spring-boot-app.txt | cut -d " " -f 1)
echo "# of config files> " $(wc -l by-configs.txt | cut -d " " -f 1)
echo "# of GET request> " $(wc -l by-get.txt | cut -d " " -f 1)
echo "# of POST request> " $(wc -l by-post.txt | cut -d " " -f 1)
echo "# of PUT request> " $(wc -l by-put.txt | cut -d " " -f 1)
echo "# of DELETE request> " $(wc -l by-delete.txt | cut -d " " -f 1)
echo "# of RequestMapping request> " $(wc -l by-request-mapping.txt | cut -d " " -f 1)
echo "# of classes extending WebSecurityConfigurerAdapter>" $(wc -l by-web-security-configurer-adpaters.txt | cut -d " " -f 1)
echo "# of classes implementing Serializable>" $(wc -l by-serializable.txt | cut -d " " -f 1)
