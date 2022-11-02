# puppet script to fix lamp stack

exec { 'wordpress debug':
  command => "sed -i 's/phpp/php/g' '/var/www/html/wp-settings.php'",
  path    => '/bin'
}
