// Generated by CoffeeScript 1.8.0
(function() {
  var $;

  $ = this.jQuery;

  $.fn.extend({
    confirmWithReveal: function(options) {
      var defaults, do_confirm, handler, settings;

      if (options == null) {
        options = {};
      }

      defaults = {
        modal_class: 'medium',
        title: 'Are you sure?',
        title_class: '',
        body: 'This action cannot be undone.',
        body_class: '',
        password: false,
        prompt: 'Type <strong>%s</strong> to continue:',
        footer_class: '',
        ok: 'Confirm',
        ok_class: 'button button_alert',
        cancel: 'Cancel',
        cancel_class: 'button secondary'
      };

      settings = $.extend({}, defaults, options);


      do_confirm = function($el) {
        var confirm_button, confirm_html, confirm_label, el_options, modal, option, password, _ref;

        el_options = $el.data('confirm');

        if ($el.attr('data-confirm') == null) {
          return true;
        }

        if ((typeof el_options === 'string') && (el_options.length > 0)) {
          return (((_ref = $.rails) != null ? _ref.confirm : void 0) || window.confirm).call(window, el_options);
        }

        option = function(name) {
          return el_options[name] || settings[name];
        };

        confirm_button = $el.is('a') ? $el.clone() : $('<a/>');

        confirm_button.removeAttr('data-confirm').attr('class', option('ok_class')).html(option('ok')).on('click', function(e) {
          if ($(this).prop('disabled')) {
            return false;
          }
          $el.trigger('confirm.reveal', e);
          if ($el.is('form, :input')) {
            return $el.closest('form').removeAttr('data-confirm').submit();
          }
        });

        var cancel_button = $("<button class='button'>Cancel</button>").on('click', function(e) {
          modal.foundation('close');
          return $el.trigger('cancel.reveal', e);
        });

        var content = `<h2>Delete Spot</h2><p>${ el_options.text }</p><div class='form-actions'></div>`,
            modal = $('#modal'),
            modal_content = $('.modal_content').html(content)

        $('.form-actions').append(confirm_button).append(cancel_button)

        modal.foundation('open').on('closed.zf.reveal');

        return false;
      };


      if ($.rails) {
        $.rails.allowAction = function(link) {
          return do_confirm($(link));
        };
        return $(this);
      } else {
        handler = function(e) {
          if (!(do_confirm($(this)))) {
            e.preventDefault();
            return e.stopImmediatePropagation();
          }
        };
        return this.each(function() {
          var $el;
          $el = $(this);
          $el.on('click', 'a[data-confirm], :input[data-confirm]', handler);
          $el.on('submit', 'form[data-confirm]', handler);
          return $el;
        });
      }
    }
  });

}).call(this);
