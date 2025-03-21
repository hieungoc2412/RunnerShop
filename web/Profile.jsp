<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin cá nhân | RunnerShop</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Custom CSS -->
        <style>

            .profile-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 100px 0 30px;
                margin-bottom: -60px;
            }

            .profile-img {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 5px solid white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .profile-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            .stats-card {
                border: none;
                border-radius: 10px;
                transition: transform 0.3s;
            }

            .stats-card:hover {
                transform: translateY(-5px);
            }

            .nav-pills .nav-link.active {
                background-color: #667eea;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25);
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            }

            .activity-item {
                border-left: 2px solid #667eea;
                padding-left: 20px;
                margin-bottom: 20px;
                position: relative;
            }

            .activity-item::before {
                content: '';
                width: 12px;
                height: 12px;
                background: #667eea;
                border-radius: 50%;
                position: absolute;
                left: -7px;
                top: 0;
            }

            /* Tabs */
            .nav-pills .nav-link {
                border-radius: 10px;
                color: #6a11cb;
                font-weight: 500;
                padding: 10px 15px;
                transition: all 0.3s ease-in-out;
            }

            .nav-pills .nav-link.active {
                background-color: #6a11cb;
                color: white;
                box-shadow: 0 4px 10px rgba(106, 17, 203, 0.3);
            }

            .nav-pills .nav-link:hover {
                background-color: #2575fc;
                color: white;
            }

            /* Form */
            .form-label {
                font-weight: bold;
                color: #333;
            }

            .form-control {
                border-radius: 8px;
                border: 1px solid #ddd;
                transition: all 0.3s ease-in-out;
            }

            .form-control:focus {
                border-color: #6a11cb;
                box-shadow: 0 0 0 0.2rem rgba(106, 17, 203, 0.25);
            }

            /* Button */
            .btn-primary {
                background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
                border: none;
                font-weight: 600;
                padding: 10px 15px;
                transition: all 0.3s ease-in-out;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%);
                box-shadow: 0 4px 15px rgba(106, 17, 203, 0.5);
            }

            /* Alert */
            .alert {
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 10px 15px;
            }

            .alert-danger {
                background-color: rgba(255, 77, 77, 0.1);
                border: 1px solid rgba(255, 77, 77, 0.4);
                color: #ff4d4d;
            }

            .alert-danger strong {
                color: #ff1a1a;
            }
            .profile-header {
                position: relative;
            }

            .btn-outline-light {
                border: 1px solid rgba(255, 255, 255, 0.6);
                color: white;
                transition: all 0.3s ease-in-out;
            }

            .btn-outline-light:hover {
                background-color: white;
                color: #764ba2;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="profile-header text-center">
            <div class="container">
                <img src="${user.imgUser != null ? user.imgUser : 'default-profile.png'}" 
                     alt="Profile Image" class="profile-img mb-4">
                <h2>${user.fullName}</h2>
                <p class="lead">Thành viên từ ${user.createdAt}</p>
            </div>
            <!-- Nút chỉnh sửa hình ảnh -->
            <button type="button" class="btn btn-outline-light btn-sm position-absolute top-0 end-0 me-3 mt-3" 
                    data-bs-toggle="modal" data-bs-target="#editImageModal">
                <i class="fas fa-edit"></i>
            </button>

            <!-- Modal chỉnh sửa hình ảnh -->
            <div class="modal fade" id="editImageModal" tabindex="-1" aria-labelledby="editImageModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="update-profile-image" method="POST" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editImageModalLabel">Cập nhật ảnh đại diện</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="profileImage" class="form-label">Chọn ảnh mới</label>
                                    <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*" required>
                                    <small class="text-muted">Chỉ hỗ trợ các định dạng: JPG, PNG (tối đa 5MB).</small>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

        <!-- Main Content -->
        <div class="container py-5">
            <div class="row">
                <!-- Thống kê -->
                <div class="col-12 mb-4">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="stats-card card bg-primary text-white p-3 text-center">
                                <h3>${stats.orders}</h3>
                                <p><strong>Tổng số đơn hàng:</strong> ${totalOrders}</p>

                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card card bg-success text-white p-3 text-center">
                                <h3>${stats.reviews}</h3>
                                <p><strong>Tổng số lượt đánh giá:</strong> ${totalFeedbacks}</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card card bg-info text-white p-3 text-center">
                                <h3>${stats.favorites}</h3>
                                <p class="mb-0">Yêu thích</p>
                            </div>
                        </div>
<!--                        <div class="col-md-3">
                            <div class="stats-card card bg-warning text-white p-3 text-center">
                                <h3>${stats.promotions}</h3>
                                <p class="mb-0">Khuyến mãi</p>
                            </div>
                        </div>-->
                    </div>
                </div>

                <!-- Thông tin cá nhân -->
                <div class="col-md-8">
                    <div class="profile-card card">
                        <div class="card-body">
                            <ul class="nav nav-pills mb-4" id="profileTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="info-tab" data-bs-toggle="pill" href="#info" role="tab">
                                        Thông tin cá nhân
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="orders-tab" data-bs-toggle="pill" href="#orders" role="tab">
                                        Đơn hàng

                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="security-tab" data-bs-toggle="pill" href="#security" role="tab">
                                        Bảo mật
                                    </a>
                                </li>
                            </ul>

                            <div class="tab-content" id="profileTabContent">
                                <!-- Tab Thông tin cá nhân -->
                                <div class="tab-pane fade show active" id="info" role="tabpanel">
                                    <c:if test="${not empty user}">
                                        <p><strong>Tên đăng nhập:</strong> ${user.userName}</p>
                                        <p><strong>Họ và tên:</strong> ${user.fullName}</p>
                                        <p><strong>Email:</strong> ${user.email}</p>
                                        <p><strong>Số điện thoại:</strong> ${user.phoneNumber}</p>
                                        <p><strong>Trạng thái:</strong> ${user.status ? 'Hoạt động' : 'Không hoạt động'}</p>
                                    </c:if>
                                    <c:if test="${empty user}">
                                        <p>Không tìm thấy thông tin người dùng.</p>
                                    </c:if>
                                    <ul class="nav nav-pills mb-4" id="profileTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link" id="update-profile-tab" data-bs-toggle="pill" href="#update-profile" role="tab">
                                                Cập nhật thông tin
                                            </a>
                                        </li>
                                    </ul>
                                    <div class="tab-pane fade" id="update-profile" role="tabpanel">
                                        <h5>Cập nhật thông tin cá nhân</h5>
                                        <form action="update-profile" method="POST">
                                            <!-- Hidden field để gửi userId -->
                                            <input type="hidden" name="userId" value="${user.userId}">

                                            <div class="mb-3">
                                                <label for="fullName" class="form-label">Họ và tên</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="phoneNumber" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                                        </form>

                                        <!-- Hiển thị thông báo lỗi nếu có -->
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger mt-3">
                                                ${errorMessage}
                                            </div>
                                        </c:if>
                                    </div>


                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                                        <i class="fas fa-plus"></i> Thêm địa chỉ mới
                                    </button>
                                </div>

                                <!-- Tab Đơn hàng -->
                                <div class="tab-pane fade" id="orders" role="tabpanel">
                                    <div class="activity-timeline">
                                        <c:forEach items="${orders}" var="order">
                                            <div class="activity-item">
                                                <h5>Đơn hàng #${order.id}</h5>
                                                <p class="text-muted">${order.status} - ${order.date}</p>
                                                <p>Tổng giá trị: ${order.total}đ</p>
                                                <a href="#" class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Tab Bảo mật -->
                                <div class="tab-pane fade" id="security" role="tabpanel">
                                    <form action="/RunnerShop/profile/change-password" method="POST">
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu hiện tại</label>
                                            <input type="password" class="form-control" name="currentPassword">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu mới</label>
                                            <input type="password" class="form-control" name="newPassword">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Xác nhận mật khẩu mới</label>
                                            <input type="password" class="form-control" name="confirmPassword">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-md-4">
                    <!-- Thao tác nhanh -->
                    <div class="profile-card card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Thao tác nhanh</h5>
                            <div class="d-grid gap-2">
                                <a href="/RunnerShop/wishlist" class="btn btn-outline-primary">
                                    <i class="fas fa-heart me-2"></i>Danh sách yêu thích
                                </a>
                                <a href="/RunnerShop/cart" class="btn btn-outline-primary">
                                    <i class="fas fa-shopping-cart me-2"></i>Giỏ hàng
                                </a>
                                <a href="/RunnerShop/reviews" class="btn btn-outline-primary">
                                    <i class="fas fa-star me-2"></i>Đánh giá của tôi
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Hoạt động gần đây -->
                    <div class="profile-card card">
                        <div class="card-body">
                            <h5 class="card-title">Hoạt động gần đây</h5>
                            <div class="activity-timeline">
                                <c:forEach items="${recentActivities}" var="activity">
                                    <div class="activity-item">
                                        <small class="text-muted">${activity.time}</small>
                                        <p class="mb-0">${activity.description}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Custom JS -->
        <script>

            function editAddress(addressId) {
                // Logic chỉnh sửa địa chỉ
            }

            function deleteAddress(addressId) {
                if (confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'profile';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'deleteAddress';

                    const addressIdInput = document.createElement('input');
                    addressIdInput.type = 'hidden';
                    addressIdInput.name = 'addressId';
                    addressIdInput.value = addressId;

                    form.appendChild(actionInput);
                    form.appendChild(addressIdInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }


            document.addEventListener("DOMContentLoaded", function () {
                const profileImageInput = document.getElementById("profileImage");
                const form = document.querySelector("form[action='update-profile-image']");

                profileImageInput.addEventListener("change", function () {
                    const file = this.files[0];
                    if (file) {
                        const allowedTypes = ["image/jpeg", "image/png"];
                        const maxSize = 5 * 1024 * 1024; // 5MB

                        if (!allowedTypes.includes(file.type)) {
                            alert("Chỉ hỗ trợ định dạng JPG và PNG.");
                            this.value = "";
                        } else if (file.size > maxSize) {
                            alert("Dung lượng ảnh không được vượt quá 5MB.");
                            this.value = "";
                        }
                    }
                });

                form.addEventListener("submit", function (event) {
                    if (!profileImageInput.value) {
                        event.preventDefault();
                        alert("Vui lòng chọn ảnh trước khi cập nhật.");
                    }
                });
            });
        </script>
    </body>
</html>