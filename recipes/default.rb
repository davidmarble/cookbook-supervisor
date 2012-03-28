script "Install supervisor" do
    interpreter "bash"
    user "root"
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
    pip install cElementTree supervisor
    EOH
    #update-rc.d supervisord defaults
    # not_if "which supervisorctl"
end

directory "/etc/supervisor/" do
    owner "root"
    group "root"
    mode "0755"
end

case node.platform
when "redhat", "centos", "fedora"
    cookbook_file "/etc/init.d/supervisord" do
        source "etc/init.d/redhat.supervisord"
        owner "root"
        group "root"
        mode "0755"
    end
    # chkconfig --add supervisord
    # chkconfig supervisord on
when "debian", "ubuntu"
    cookbook_file "/etc/init.d/supervisord" do
        source "etc/init.d/debian.supervisord"
        owner "root"
        group "root"
        mode "0755"
    end
    # sudo update-rc.d supervisord defaults
end

service "supervisord" do
    supports :restart => true, :reload => true, :status => true
    action :enable
end

node[:supervisor][:includes].each do |inc|
    template "/etc/supervisor/#{inc}.conf" do
        source node[:supervisor].attribute?("config_cookbook") ? "supervisor/#{inc}.conf.erb" : "etc/supervisor/#{inc}.conf.erb"
        source "etc/supervisor/#{inc}.conf.erb"
        owner "root"
        group "root"
        mode "0644"
        cookbook node[:supervisor].attribute?("config_cookbook") ? node[:supervisor][:config_cookbook] : "supervisor"
        notifies :restart, resources(:service => "supervisord")
    end
end

template "/etc/supervisord.conf" do
    source "etc/supervisord.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, resources(:service => "supervisord")
end

case node.platform
when "redhat", "centos", "fedora"
    execute "sudo /sbin/service supervisord start" do
        not_if "pgrep -f supervisord"
    end
when "debian", "ubuntu"
    execute "sudo /etc/init.d/supervisord start" do
        not_if "pgrep -f supervisord"
    end
end
