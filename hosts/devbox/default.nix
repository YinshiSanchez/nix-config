# { inputs, outputs, pkgs, pkgs-unstable,  mylib, ... }: {
{...}: {
  xdg.enable = true;

  home = {
    username = "zhangzhixin.2892";
    homeDirectory = "/home/zhangzhixin.2892";
    sessionVariables = {
      GOPATH = "$HOME/go";
    };

    sessionPath = [
      "/opt/tiger/toutiao/lib"
      "/opt/tiger/ss_bin"
      "/usr/local/jdk/bin"
      "/usr/sbin/"
      "/opt/tiger/ss_lib/bin"
      "/opt/tiger/ss_lib/python_package/lib/python2.7/site-packages/django/bin"
      "/opt/tiger/yarn_deploy/hadoop/bin/"
      "/opt/tiger/yarn_deploy/hive/bin/"
      "/opt/tiger/yarn_deploy/jdk/bin/"
      "/opt/tiger/hadoop_deploy/jython-2.5.2/bin"
      "/opt/tiger/dev_toolkit/bin"
      "/opt/tiger/bgdb_v3_master/bggs_v3_lib"
    ];
  };
}
