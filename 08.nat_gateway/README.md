Nat Gateway を経由して private subnet にある Web サーバからインターネットに出る。  
Web サーバから `curl http://www.google.com` で 80 番が外に出られる事を確認できる。

- ネットワーク
  - VPC
  - Subnet
  - Route Table
  - Internet Gateway
- Security Group
  - Security Group Rule
- EC2
  - キーペア
  - Web
  - 踏み台
- NatGateway
