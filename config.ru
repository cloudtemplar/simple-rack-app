require './config/application'

use OTR::ActiveRecord::ConnectionManagement

run TodoList::App.instance
