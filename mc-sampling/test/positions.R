library(tidyverse)
theme_set(theme_minimal(
    base_size = 32, base_family = "Fira Sans Condensed"
))

fnames <- list.files(
    path = "../dump", pattern = "*_x.txt", full.names = TRUE
)

g01 <- scan(fnames[1]) |> matrix(nrow = 100, ncol = 60, byrow = TRUE)
g04 <- scan(fnames[2]) |> matrix(nrow = 100, ncol = 60, byrow = TRUE)
g07 <- scan(fnames[3]) |> matrix(nrow = 100, ncol = 60, byrow = TRUE)
g10 <- scan(fnames[4]) |> matrix(nrow = 100, ncol = 60, byrow = TRUE)

idx <- 96
gammas <- c("0.1", "0.4", "0.7", "1.0")
data <- list(g01, g04, g07, g10)
pal <- c("#90a955", "#4f772d", "#31572c", "#132a13")

for (i in seq_along(gammas)) {
    plt <- tibble(
        x = data[[i]][idx, seq(1, 60, 2)] / 10,
        y = data[[i]][idx, seq(2, 60, 2)] / 10
    ) |>
        ggplot(aes(x, y)) +
            geom_point(size = 8, colour = pal[i]) +
            labs(
                x = "x / L", y = "y / L",
                title = paste("Sampling with γ =", gammas[i])
            ) +
            coord_cartesian(xlim = c(0, 1), ylim = c(0, 1), expand = FALSE)

    ggsave(
        paste0("img/gamma_", gammas[i], "_conf.png"), plot = plt,
        device = "png", dpi = 300, width = 7, height = 7,
    )
}
