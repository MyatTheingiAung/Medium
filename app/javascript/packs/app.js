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
    })

    $('#imageInput').on('change', function() {
        var $image = $(".db-img");
        $image.css('display','none');
        $input = $(this);
        if($input.val().length > 0) {
            fileReader = new FileReader();
            fileReader.onload = function (data) {
            $('.image-preview').attr('src', data.target.result);
            }
            fileReader.readAsDataURL($input.prop('files')[0]);
            $('.image-preview').removeClass('d-none');
            $('.image-preview').addClass('mb-4');
        }
    });
});
