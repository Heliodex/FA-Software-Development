# Project plan


3 days - Development of basic web server for basic HTML page hosting
1 day - Load styles and static content from a directory
5 days - Design of complex pages, certain page parts
3 days - Begin creation of content, page hierarchy fleshed out


# Development log

## 1 day

Begin work on basic web server. HTML pages and static content is loaded from a directory, and can be accessed via a URL.

## 2 days

Web server supports page layouts and components, preventing duplication of layout code (eg. navbar, footer, global styles, etc).

## 1 day

Integrate CSS with global styles for site, and scoped styles for specific pages. Web server is now capable of displaying HTML/CSS/JS page content as well as serving static files such as fonts and images, and is hostable on a server to allow access outside of the local network.

## 1 week

Design of content and layout for more complex pages was worked on, including header and navigation bar, responsive design, and site page hierarchy.

## 1 day

Site name and basic content were decided upon. Contact page now has some basic information, and global styling was improved. Navigation bar with links to site pages was added.

## 1 day

Fonts improved with statically hosted font files, Gallery page was added. Basic development testing for design and layout began.

## 3 days

Visit page added with opening times, Walks page was also added. Styling improved with background imagery.

## 3 days

Gallery page updated to use a 3-column grid layout, images added with links to their high-resolution originals. Hovering on an image shows a larger preview version.

## 2 days

Café page added with full table menu, Petting zoo page also added with list of animals alongside images. Designs for more complex pages were revisited and improved.

## 2 days

Responsiveness improved, popover navigation menu added on smaller screens, and Gallery page improved with media queries to reduce number of columns on small screens.

## 1 day

Final styling improvements. Pages with lists of content were generated dynamically with a template loop. Site was made availabe on a domain name.

## 1 day

Final production testing completed on multiple browsers, with live site.

# Test plan

During development, basic layout and performance testing was performed.

Test|Description
-|-
Layout|Ensuring that layout is consistent across all pages, and that content is displayed correctly.
Responsiveness|Making sure layout is displayed correctly on different screen sizes, with appropriate methods for handling smaller screens.
Performance|Ensuring that the site is performant, with minimal load times and no errors. Images should be fully optimised by default to ensure correct sizing, and no unnecessary network requests should be made.
Compatibiliy|Ensuring that the site is compatible with different browsers, operating systems, and devices.
