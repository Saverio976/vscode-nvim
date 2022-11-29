#!/bin/bash

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerCompile'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
