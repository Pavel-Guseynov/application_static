include_recipe "nginx"

node['application_static']['apps'].each do |app|
	log "#{node['application_static']['app_path']}/#{app['name']}" do
	  level :warn
	end

	application app['name'] do
	  path  "#{node['application_static']['app_path']}/#{app['name']}"
	  owner node['nginx']['user']
	  group node['nginx']['group']

	  repository app['url']
	  deploy_key node['application_static']['deploy_key']
	end

	#inspired by https://github.com/miketheman/nginx/blob/master/recipes/commons_conf.rb#L31
	template "#{node['nginx']['dir']}/sites-available/#{app['name']}" do
		source 'site.erb'
		owner 'root'
		group node['root_group']
		mode '0644'
		variables :app => app
		notifies :reload, 'service[nginx]'
	end

	#inspired by https://github.com/miketheman/nginx/blob/master/recipes/commons_conf.rb#L39
	nginx_site app['name'] do
		enable app['enabled']
	end
end
