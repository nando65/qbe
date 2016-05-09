jQuery ->
   if $('.pagination').length
     $(window).scroll ->
        url = decodeURIComponent( $('.last-loaded-page:last').val() )
        if url && $(window).scrollTop() > $(document).height() - $(window).height() - 20
          $('.pagination').text("Fetching more results...")
          $.getScript(url)
      $(window).scroll()