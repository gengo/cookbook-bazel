if platform_family?('mac_os_x')
  package 'python3' if node.bazel.install_python3
else
  python_runtime('2') if node.bazel.install_python2
  python_runtime('3') if node.bazel.install_python3
  package 'python'
end
