package erreeffe.entity;

// Generated 20-nov-2008 2.05.45 by Hibernate Tools 3.2.2.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class StranieriTot.
 * @see erreeffe.entity.StranieriTot
 * @author Hibernate Tools
 */
public class StranieriTotHome {

	private static final Log log = LogFactory.getLog(StranieriTotHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(StranieriTot transientInstance) {
		log.debug("persisting StranieriTot instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(StranieriTot instance) {
		log.debug("attaching dirty StranieriTot instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(StranieriTot instance) {
		log.debug("attaching clean StranieriTot instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(StranieriTot persistentInstance) {
		log.debug("deleting StranieriTot instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public StranieriTot merge(StranieriTot detachedInstance) {
		log.debug("merging StranieriTot instance");
		try {
			StranieriTot result = (StranieriTot) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public StranieriTot findById(erreeffe.entity.StranieriTotId id) {
		log.debug("getting StranieriTot instance with id: " + id);
		try {
			StranieriTot instance = (StranieriTot) sessionFactory
					.getCurrentSession()
					.get("erreeffe.entity.StranieriTot", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<StranieriTot> findByExample(StranieriTot instance) {
		log.debug("finding StranieriTot instance by example");
		try {
			List<StranieriTot> results = (List<StranieriTot>) sessionFactory
					.getCurrentSession().createCriteria(
							"erreeffe.entity.StranieriTot").add(
							create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
