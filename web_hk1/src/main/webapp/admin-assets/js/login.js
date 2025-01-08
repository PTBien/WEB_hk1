(function () {
    'use strict';

    // Show/Hide password
    $(function () {
        $('.click-eye').click(function () {
            $(this).toggleClass('bx-show bx-hide')
            var input = $($(this).attr('toggle'))
            if (input.attr('type') == 'password')
                input.attr('type', 'text')
            else
                input.attr('type', 'password')
        });
    })

    // Forgot password
    $(function () {
        $('#btn-forgot').click(function () {
            var email = $('#field-email').val()
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

            if (!emailRegex.test(email)) {
                swal({
                    title: 'Định dạng email không chính xác',
                    text: 'Vui lòng nhập lại',
                    icon: 'error',
                    close: true,
                    button: 'Thử lại'
                })

                return false
            } else {
                swal({
                    text: 'Đang xác thực email, vui lòng đợi...',
                    icon: 'success',
                    close: true,
                    buttons: false
                })

                return true
            }
        })
    })
})()