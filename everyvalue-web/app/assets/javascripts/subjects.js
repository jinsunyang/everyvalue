$(":file").filestyle();

// $(document).ready(function() {
//     // disable auto discover
//     Dropzone.autoDiscover = false;
//
//     // grap our upload form by its id
//     $("#subject_attachments_upload").dropzone({
//         // restrict image size to a maximum 1MB
//         maxFilesize: 5,
//
//         // changed the passed param to one accepted by our rails app
//         paramName: "subject_attachments[content]",
//
//         // show remove links on each image upload
//         addRemoveLinks: true,
//         dictDefaultMessage: "Arrastre sus fotos aqui.",
//         autoProcessQueue: false,
//         uploadMultiple: true,
//         parallelUploads: 5,
//         maxFiles: 5,
//
//
//         // The setting up of the dropzone
//         init: function () {
//             console.log(1111);
//
//             var myDropzone = this;
//
//             // First change the button to actually tell Dropzone to process the queue.
//             this.element.querySelector("button[type=submit]").addEventListener("click", function (e) {
//                 // Make sure that the form isn't actually being sent.
//                 e.preventDefault();
//                 e.stopPropagation();
//                 myDropzone.processQueue();
//             });
//
//             // Listen to the sendingmultiple event. In this case, it's the sendingmultiple event instead
//             // of the sending event because uploadMultiple is set to true.
//             this.on("sendingmultiple", function () {
//                 // Gets triggered when the form is actually being sent.
//                 // Hide the success button or the complete form.
//             });
//             this.on("successmultiple", function (files, response) {
//                 // Gets triggered when the files have successfully been sent.
//                 // Redirect user or notify of success.
//             });
//             this.on("errormultiple", function (files, response) {
//                 // Gets triggered when there was an error sending the files.
//                 // Maybe show form again, and notify user of error
//             });
//         }
//
//
//     });
// });