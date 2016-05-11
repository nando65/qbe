jQuery ->
   if $('.pagination').length
     requested_links = []
     $(window).scroll ->
        url = decodeURIComponent( $('.last-loaded-page:last').val() )
        if url && $(window).scrollTop() > $(document).height() - $(window).height() - 20 && $.inArray(url, requested_links) < 0
          requested_links.push(url)
          $('.pagination').text("Fetching more results...")
          $.getScript(url)
