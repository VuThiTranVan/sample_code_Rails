$(document).ready(function () {
  $('#micropost_picture').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 2) {
      alert(I18n.t("micropost.flash.danger_image_upload_too_large_size", {size: 2}));
    }
  });
});
