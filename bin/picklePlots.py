#!/usr/bin/env python3
import os, sys, pickle
import matplotlib.pyplot as plt

def add_canvas(fig): # adds a canvas manager
        dummy = plt.figure()
        newManager = dummy.canvas.manager
        newManager.canvas.figure = fig
        fig.set_canvas(newManager.canvas)

if __name__ == "__main__":
    figPkls = sys.argv[1:]
    if len(figPkls) < 1:
        raise FileNotFoundError("please pass a file")

    filePaths = [os.path.abspath(fig) for fig in figPkls]

    figObs = []
    for f in filePaths:
        if f.endswith(".pickle") or f.endswith(".pkl"):
            figOb = pickle.load(open(f, "rb"))
            figObs.append(figOb)
        else:
            raise TypeError("invalid file passed")

    figObs = [add_canvas(fig) for fig in figObs]
    plt.show(figObs)
