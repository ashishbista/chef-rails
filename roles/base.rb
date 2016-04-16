name 'base'

description "Defines base run list items and attributes for all nodes."

run_list(
  "recipe[base]",
  "recipe[rvm::user]"
)

