class nginx::config {

  include nginx::config::default
  include nginx::config::cluster
}
