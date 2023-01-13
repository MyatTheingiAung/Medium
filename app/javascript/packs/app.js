$(document).ready(function(){
    $(function () {
        $(document).scroll(function () {
            var $sidebar = $(".sidebar");
            if($sidebar.height() > window.innerHeight){
                $result = $sidebar.height() - window.innerHeight;
                $result = $result + 96;
                if($(this).scrollTop()){
                    $sidebar.css('position','sticky');
                    $sidebar.css('top', -$result+'px')
                }
            }
        });
        $(document).scroll(function () {
            var $nav = $(".navbar");
            var $blk = $(".blk");
            var $start = $(".get-start");
            $nav.toggleClass('scrolled', $(this).scrollTop() > $blk.height());
            $start.toggleClass('set-color', $(this).scrollTop() > $blk.height());
        });
    });

    $('#update-image').on('click', function(){
        $('#selectedFile').click();
    });
    $('.search-form').addClass('d-none');
    $('.search-btn').on('click', function(){
        $('.search-form ').removeClass('d-none');
        $('.search-form ').addClass('d-block');
    });
});
