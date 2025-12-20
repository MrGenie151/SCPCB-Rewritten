package engine;

import engine.renderables.Entity;

class World {

	private static function getVisible() {
		var visibleList : List<Entity> = new List<Entity>();
		for (entity in Entity.orphans) {
			if (entity.isVisible())
				visibleList.add(entity);
		}
		return visibleList;
	}

    public static function render() {
		for (entity in getVisible()) {
			entity.draw();
		}
	}
}
