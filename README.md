# devops-netology
my first line

������ ��� �����.
� ��������� ����� .terraform ���� �������������� ��������� �������:

*.tfstate - ��� ����� � ����������� TFSTATE

*.tfstate.* - ��� ����� TFSTATE � ����� ���. �����������

crash.log - ��������� ���� crash.log (��� ������ � "�������")


*.tfvars - ��� ����� � ����������� TFVARS, ���� �� ����� ����� ���������� ���������������� ���������� ��� ������, ����� � �.�

override.tf - ��������� ���� ���� 
override.tf.json - ��������� ���� ����
*_override.tf 
*_override.tf.json - ��� ���� ������ TF � TF.JSON ������������ � ������ ����� � ��������������� �� _override

������ ������ ����� - ��� ����� �������������� ��� ���������� ��������������� �������� (���-�� ��� �� �������)

#!example_override.tf - ��������� �� �������� ���� �� ����� ���� example_override.tf, �� ��� ������ � ������� ������� (�������)

# example: *tfplan* - ��� �� ������ �������, �� ����� ������ ��� ���������� ������ ���� TFPLAN ��� ������ example:(������ ��� ����)tfplan(������ ��� ����)

.terraformrc - ������������ ���� ������������ .terraformrc
terraform.rc - ������������ ���� ������������ terraform.rc



�������� ������� � ������� �2.4. ����������� Git�

������� ������ ��� � ����������� �������, ��� �������� ���������� �� aefea ?
������ ������� git show aefea � �������� ���������:

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545

����������� - Update CHANGELOG.md

2)	������ ���� ������������� ������ 85024d3?
���������� ������ ������� git show 85024d3 � �������� ���������:

tag: v0.12.23

3)	������� ��������� � ������� b8d720? �������� �� ����?
������ ������� git show --no-patch �format=%P b8d720 � �������� ���������:

1 ������ -56cd7859e05c36c06b56d013b55a252d0bb7e158   
2 ������- 9ea88f22fc6269854151c571162c5bcf958bee2b

4)	����������� ���� � ����������� ���� �������� ������� ���� ������� ����� ������ v0.12.23 � v0.12.24
������ ������� git log v0.12.23..v0.12.24 --oneline -s � �������� ���������:
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release

5)	������� ������ � ������� ���� ������� ������� func providerSource, �� ����������� � ���� �������� ��� func providerSource(...) (������ ��������� 
����������� ���������)
������ ������� 
git log -S 'func providerSource' �-oneline
�������� 2 �������
5af1e6234 main: Honor explicit provider_installation CLI config when present
8c928e835 main: Consult local directories as potential mirrors of providers
������ ������� 
git log -S 'func providerSource' �-p

������ ��� ���� �������, � ��� �������� ������� 
func providerSource
func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
+       if len(configs) == 0 {
+               // If there's no explicit installation configuration then we'll build
+               // up an implicit one with direct registry installation along with
+               // some automatically-selected local filesystem mirrors.
+               return implicitProviderSource(services), nil

��� ������ - 5af1e6234

6)	������� ��� ������� � ������� ���� �������� ������� globalPluginDirs
���� ����������� �����, � ��������� ���� ��� ���� �������� ��

git log -S "globalPluginDirs" �p

���� ������� �����, ��
git log -S "globalPluginDirs" --oneline
35a058fb3 main: configure credentials from the CLI config file
c0b176109 prevent log output during init
8364383c3 Push plugin discovery down into command package

7)	��� ����� ������� synchronizedWriters?

����, ������� ���-�� ����� �� ������ ����� Git blame � git grep, �� ������ �� ����������. ���� ���������� ���� ���.
����������� �������
$ git log -S 'synchronizedWriters' �oneline
bdfea50cc remove unused
fd4f7eb0b remove prefixed io
5ac311e2a main: synchronize writes to VT100-faker on Windows
����� ��� ������ ��� ����������� ������ �������, ����� ����� git show ���������� �������. ����� ������� - Martin Atkins <mart@degeneration.co.uk>
