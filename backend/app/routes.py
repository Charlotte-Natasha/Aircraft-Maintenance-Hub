from flask import Blueprint, jsonify
from .models import get_all_items, get_status_summary

api = Blueprint("api", __name__)

@api.route("/items", methods=["GET"])
def items():
    return jsonify(get_all_items())

@api.route("/status", methods=["GET"])
def status():
    return jsonify(get_status_summary())
