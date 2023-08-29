Jekyll::Hooks.register :site, :post_write do |site|
  system("npx -y pagefind --source '_site'" % {:path => site.dest})
end