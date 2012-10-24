class GraphingController < ApplicationController

  def hist
    id=1
    @image="hist_#{id}.png"
    generate_hist(@image)
    render(:index)
  end

  def volcano
    id=1
    @image="volcano_#{id}.png"
    generate_volcano(@image)
    render(:index)
  end

  private

  def generate_hist(img)
    x=$rsruby.rnorm(100)
    $rsruby.png("#{Rails.root}/public/#{img}")
    $rsruby.hist(x, :xlim=>[-4,4],
                    :main=>'1000 Normal Random Variables',
                    :xlab=>'x',
                    :ylab=>'y',
                    :col=>'lavender')
    $rsruby.dev_off.call
  end

  def generate_volcano(img)
    id = 1 # user's id

    $rsruby.eval_R("z <- 2 * volcano")
    $rsruby.eval_R("x <- 10 * (1:nrow(z))")
    $rsruby.eval_R("y <- 10 * (1:ncol(z))")
    $rsruby.eval_R("z0 <- min(z) - 20")
    $rsruby.eval_R("z <- rbind(z0, cbind(z0, z, z0), z0)")
    $rsruby.eval_R("x <- c(min(x) - 1e-10, x, max(x) + 1e-10)")
    $rsruby.eval_R("y <- c(min(y) - 1e-10, y, max(y) + 1e-10)")
    $rsruby.eval_R("fill <- matrix('green3', nr = nrow(z)-1, nc = ncol(z)-1)")
    $rsruby.eval_R("fill[ , i2 <- c(1,ncol(fill))] <- 'gray'")
    $rsruby.eval_R("fill[i1 <- c(1,nrow(fill)) , ] <- 'gray'")
    $rsruby.eval_R("fcol <- fill")
    $rsruby.eval_R("zi <- volcano[ -1,-1] + volcano[ -1,-61] + volcano[-87,-1] + volcano[-87,-61]  ## / 4")
    $rsruby.eval_R("fcol[-i1,-i2] <- terrain.colors(20)[cut(zi, quantile(zi, seq(0,1, len = 21)), include.lowest = TRUE)]")
    $rsruby.eval_R("par(mar=rep(.5,4))")

    $rsruby.eval_R("png('#{Rails.root}/public/#{img}')")
    $rsruby.eval_R("persp(x, y, 2*z, theta = 110, phi = 40, col = fcol,
                      scale = FALSE, ltheta = -120, shade = 0.4, border=NA, box=T)")
    $rsruby.eval_R("dev.off()")
  end
end
