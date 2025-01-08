(function () {
    'use strict';

    var treeviewMenu = $('.app-menu')

    // Toggle Sidebar
    $('[data-toggle="sidebar"]').click(function (e) {
        e.preventDefault()
        $('.app').toggleClass('sidenav-toggled')
    });

    // Activate sidebar treeview toggle
    $("[data-toggle='treeview']").click(function (e) {
        e.preventDefault();
        if (!$(this).parent().hasClass('is-expanded')) {
            treeviewMenu.find("[data-toggle='treeview']").parent().removeClass('is-expanded')
        }
        $(this).parent().toggleClass('is-expanded');
    });

    // Set initial active toggle
    $("[data-toggle='treeview.'].is-expanded").parent().toggleClass('is-expanded')

    // Activate bootstrip tooltips
    $("[data-toggle='tooltip']").tooltip()

    // Check all
    $('#all').click(function () {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    // Search
    $(document).ready(function () {
        $('#search').on('input', function () {
            var value = $(this).val().toLowerCase();
            $('#sampleTable tbody tr').filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            })
            let rows = $('#sampleTable tr:visible').length
            $('.search-bar span.quantity').html(String(rows - 1))
        })
    })
})();

