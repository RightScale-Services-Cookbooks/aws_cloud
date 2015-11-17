site :opscode

metadata
cookbook 'fog', github: 'RightScale-Services-Cookbooks/fog', branch: 'master'

group :integration do
  cookbook 'apt'#, '~> 2.3.0'
  cookbook 'yum-epel'#, '~> 0.4.0'
  #cookbook 'curl', '~> 1.1.0'
  cookbook 'fake', path: './test/cookbooks/fake'
end