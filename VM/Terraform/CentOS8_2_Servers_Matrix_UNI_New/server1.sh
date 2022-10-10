#!/bin/bash

echo "cd to root directory..."
cd root

echo "whoami..."
whoami

echo "pwd..."
pwd

# commented out to speed things up, do not do this in production
# echo "upgrading..."
# sudo yum upgrade -y

echo "installing gfortran..."
sudo yum install gcc-gfortran -y

echo "installing git..."
sudo yum install git -y

echo "installing gitlab server key..."
touch .ssh/known_hosts
ssh-keyscan git.cardiff.ac.uk >> .ssh/known_hosts
chmod 644 .ssh/known_hosts

echo "installing gitlab deployment key..."
touch cm6212_matrix_keypair.key
cat << `EOF` >> cm6212_matrix_keypair.key
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAxwlBUSoHCs5F/P4SIuPZb7S5ratJCmi7ZdMV/tQI9jb/AxSv
31u4i5tuzXabOP+h5wBsx5ugIPCDJmMO0nZyaLZr1hVWqv35ycJ8NkocZjVVay7+
s+xdyggaS6G+8kZonR5oDBIuUaDw1a7LNKiKa0eEl+B1MnsQjfeUPHoNgcGuay65
IUIzCFhPq/ZwnJ4G1CwIPsIo718ficp7QDmsldVCP5tAgpfm6ErcmQrmFun/D+d6
3/VdgOZcX28PDT9wGwsLg0m3rkXRpZqPgO+DmIarTYCYOzL5WPu0MdH+AgLpint5
KSq0voWIhhTRfK6JSJuTiLPat1A7u0OxrnlDqQIDAQABAoIBABGRrpNUi2SXyrPH
VaCAzlu+7zj2Sq9BiXE2jdV9sADT3/TMqa2ksgiYwtIeKxt/7TGv5upDwYHG2TzV
N6S6UeUOXTx7i7fyTU9S/JXqOtGG2bBpaJBHSAwiZPfSIkHOl0NvQK34GOCZvUiP
cl6GlhlcKcciSBYZqN9vQEWKXJDcePkmwVIyqmZhKskPq/SXWxNJKzEjeb4AuWUO
tmmC9ZbT1wF2eHhvWuNAISoVzxA88Y73bPWae9IthIh3EIKz4u+ciciTHAkER1Ub
snKIXFyCdaELPDUqF/xQt0LS7YAu5dZvMmpVlb+7bQZXdLfFhj7G0V+4KB0VvNJp
YMiH0mUCgYEA7krPJRGlxjeDEVNa8PXdY3pragAAIc2w0e9hR2V3vLmHjrrfWNDc
5ar7cJOiHZGQefALRIPgqS9dVJjLgiJUMk6Kn1KSMUQcWqyatLj0snvMYazTW/ij
hrGQxo1v/kjPFLtSf9igVoMIl9miicunB8ReZ1RS+HSnEu7WgRLeDFsCgYEA1dOm
2RjFmPpFuczWkyewrYAQbaR279Vp073lh+yTKGFZ9264MNj9dSdnkL24vaH7DNm4
jFc83eLvACpQIsQ5ijNeELc0YNa+UHS6Tz5GXD9XSfWaX2xG6V1w4HmrwNX+PaDe
25kGoAWJYsQ7oC+rPS11Dogf7cFcprCgjunn/0sCgYEA3m2qCdn9OZbbmzKJct6t
Noww85LojKUpZeziivhl2h38MPiyPn9HkoIVjjHgY2VazNeKTPwkmwgBQFQXsnNE
0GiL8Mfselwvc1wmVIdIscnpL0tZR0JBshrRHuUrItrnoVxxV7DniZlqTgPyOlmE
ojVkQWNux0hsI7oZNAZein0CgYEAxyDb+MFBAz3PQUCpc1E7D9h7dB/9Q0yTyUTH
RNXkFW7TwcGydosdPsT7haepK7B1g3oei1OSs3Bq8tR03GuwyiscJqT2eliB05th
BfsQu0ehmpbGtKa5Qwpp3CJy+JpQskPmRssziEKftwLYJE1AQzDaGjZaxaeVCQbj
/zOFghECgYEA7UwLdZ11Lt/i+JWYwiOAd2wkNtLHifgUYy/w3ImbPFogFERJOkh2
B6lveB5ltTo9D1NmgKBaWmNxBD8HWx6bsyMl5Ewp4lw9L7AUzk58UM/vhUbW8KXt
2bPnMgo84QVZhr7JOZgaLalBGMGqM+m0Vhw/jZeFDvvm0NYz53J+HlA=
-----END RSA PRIVATE KEY-----
`EOF`
chmod 400 cm6212_matrix_keypair.key

echo "cloning repository..."
ssh-agent bash -c 'ssh-add cm6212_matrix_keypair.key; git clone git@git.cardiff.ac.uk:cm6212/matrix.git'

echo "changing to repository directory..."
cd matrix

echo "enabling execution..."
chmod a+x *.sh

echo "compiling matrix..."
./make.sh

echo "running matrix..."
nohup ./run.sh &