# NT548.P11 - Lab 1: Dùng CloudFormation để triển khai và quản lý hạ tầng AWS

## Danh sách các thành viên thực hiện:

|Họ và tên|MSSV|
|---|---|
| Vũ Tuấn Sơn | 21521389 |
| Lê Thanh Lâm | 21521052 |
| Nguyễn Mạnh Hùng | 21520896 |
| Nguyễn Huy Cường | 21520667 |

## Các module trong bài được chia như sau:

- **VPC**: Bao gồm 1 Public Subnet, 1 Private Subnet, Internet Gateway và Security Group mặc định.
- **Route Table**: Quản lý định tuyến trong VPC.
- **NAT Gateway**: Cho phép kết nối từ Private Instance ra Internet thông qua Public Subnet.
- **EC2**: Tạo 2 instance chạy hệ điều hành Ubuntu, 1 nằm trong Public Subnet và 1 nằm trong Private Subnet.
- **Main**: Tạo một Stack để triển khai tuần tự tất cả các module trên lên AWS Cloud.

## Quy trình thực hiện:

1. Tạo một S3 Bucket trên AWS.
2. Upload các file template của từng module lên S3 Bucket này.
3. Sử dụng file `main.yaml` trong CloudFormation để tự động triển khai tất cả các module đã upload lên S3.

Sau khi triển khai thành công, ta sẽ truy cập vào Public EC2 Instance bằng EC2 Instance Connect từ AWS Console để kiểm tra các thiết lập đã đúng hay chưa.
