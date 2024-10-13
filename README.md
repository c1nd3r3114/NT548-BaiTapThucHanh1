# NT548.P11 - Lab 1: Dùng CloudFormation để triển khai và quản lý hạ tầng AWS

Danh sách nhóm thành viên thực hiện:

|Họ và tên|MSSV|
|---|---|
| Vũ Tuấn Sơn | 21521389 |
| Lê Thanh Lâm | 21521052 |
| Nguyễn Mạnh Hùng | 21520896 |
| Nguyễn Huy Cường | 21520667 |

Các module được chia như sau:
- **VPC**: gồm có 1 Public Subnet, 1 Private Subnet, Internet Gateway và Security Group mặc định.
- **Route Table**: quản lý routing trong VPC.
- **NAT Gateway**: tạo kết nối cho Private Instance đến Public Subnet
- **EC2**: gồm 2 instance ở hệ điều hành Ubuntu. 1 instance nằm trong Public Subnet, 1 instance nằm trong Private Subnet.
- **Main**: tạo Stack để thực hiện tuần tự việc triển khai các module trên lên AWS Cloud.