class ppa {

  include ppa::install
  include ppa::repositories::nathan-renniewaldock-ppa
  include ppa::repositories::nginx-stable
}
