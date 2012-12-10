class ppa {

  include ppa::install
  include ppa::repository
  include ppa::repositories::nathan-renniewaldock-ppa
  include ppa::repositories::nginx-stable
}
